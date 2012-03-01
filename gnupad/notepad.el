;|
;| File          : ~/emacs.d/notepad.el
;| Version       : 0.1
;| Last modified : 2011-08-05
;| Author        : Fabien Cazenave
;| License       : WTFPL
;|
;| This configuration file should bring a Notepad-like behavior to Emacs.
;| It reuses a small subset of ErgoEmacs but tries to remain as simple as possible.
;| It's designed for Emacs haters -- and certainly not for advanced Emacs users.
;|
;| We're missing [F3] / Shift+[F3] to get the next/previous search occurrences.
;| It would be nice if this configuration file could be activated/disactivated
;| along with cua-mode.
;| If you know how to do that, please ping me.
;|
;| I'd also like to have a few Notepad++ features, too -- e.g. tabs.
;| That could be another configuration file, though.
;|

;; CUA-Mode brings C-[z|x|c|v] shortcuts
(cua-mode 1)
(require 'redo "redo.elc" t) ; for redo shortcut
(global-set-key (kbd "C-S-z") 'redo)

;; basic Notepad-like shortcuts
(defun close-frame ()
  "Closes the current frame or kills emacs if there are just one frame. It simulates the same functionality of the Close button in the frame title bar."
  (interactive)
  (if multiple-frames
      (delete-frame)
    (save-buffers-kill-terminal)))

(global-set-key (kbd "C-n")   'make-frame-command) ; New
(global-set-key (kbd "C-o")   'find-file)          ; Open...
(global-set-key (kbd "C-s")   'save-buffer)        ; Save
(global-set-key (kbd "C-S-s") 'write-file)         ; Save As...
(global-set-key (kbd "C-a")   'mark-whole-buffer)  ; Select All
(global-set-key (kbd "C-f")   'search-forward)     ; Find...
(global-set-key (kbd "C-g")   'query-replace)      ; Find and replace...
(global-set-key (kbd "C-q")   'close-frame)        ; Quit

;; text zoom
(defun text-scale-reset ()
  "Set the height of the default face in the current buffer to its default value."
  (interactive)
  (text-scale-increase 0))
(global-set-key (kbd "C--")   'text-scale-decrease)
(global-set-key (kbd "C-+")   'text-scale-increase)
(global-set-key (kbd "C-=")   'text-scale-increase)
(global-set-key (kbd "C-0")   'text-scale-reset)

;; selection with Shift + caret movement keys -- not working with Org-mode :-/
(defun ergoemacs-fix-cua--pre-command-handler-1 ()
  "Fixes CUA minor mode so selection is highlighted only when Shift+<special key> is used (arrows keys, home, end, pgdn, pgup, etc.)."
 (defun cua--pre-command-handler-1 ()
  ;; Cancel prefix key timeout if user enters another key.
  (when cua--prefix-override-timer
    (if (timerp cua--prefix-override-timer)
        (cancel-timer cua--prefix-override-timer))
    (setq cua--prefix-override-timer nil))

  (cond
   ;; Only symbol commands can have necessary properties
   ((not (symbolp this-command))
    nil)

   ;; Handle delete-selection property on non-movement commands
   ((not (eq (get this-command 'CUA) 'move))
    (when (and mark-active (not deactivate-mark))
      (let* ((ds (or (get this-command 'delete-selection)
                     (get this-command 'pending-delete)))
             (nc (cond
                  ((not ds) nil)
                  ((eq ds 'yank)
                   'cua-paste)
                  ((eq ds 'kill)
                   (if cua--rectangle
                       'cua-copy-rectangle
                     'cua-copy-region))
                  ((eq ds 'supersede)
                   (if cua--rectangle
                       'cua-delete-rectangle
                     'cua-delete-region))
                  (t
                   (if cua--rectangle
                       'cua-delete-rectangle ;; replace?
                     'cua-replace-region)))))
        (if nc
            (setq this-original-command this-command
                  this-command nc)))))

   ;; Handle shifted cursor keys and other movement commands.
   ;; If region is not active, region is activated if key is shifted.
   ;; If region is active, region is cancelled if key is unshifted
   ;;   (and region not started with C-SPC).
   ;; If rectangle is active, expand rectangle in specified direction and
   ;;   ignore the movement.
   ((if window-system
        ;; Shortcut for window-system, assuming that input-decode-map is empty.

        ;; ErgoEmacs patch begin ------------------
        ;;;; (memq 'shift (event-modifiers
        ;;;;               (aref (this-single-command-raw-keys) 0)))
        (and (memq 'shift (event-modifiers
                           (aref (this-single-command-raw-keys) 0)))
             ;; In this way, we expect to use CUA only with keys that
             ;; are symbols (like <left>, <next>, etc.)
             (symbolp (event-basic-type (aref (this-single-command-raw-keys) 0))))
        ;; ErgoEmacs patch end --------------------

      (or
       ;; Check if the final key-sequence was shifted.
       (memq 'shift (event-modifiers
                     (aref (this-single-command-keys) 0)))
       ;; If not, maybe the raw key-sequence was mapped by input-decode-map
       ;; to a shifted key (and then mapped down to its unshifted form).
       (let* ((keys (this-single-command-raw-keys))
              (ev (lookup-key input-decode-map keys)))
         (or (and (vector ev) (memq 'shift (event-modifiers (aref ev 0))))
             ;; Or maybe, the raw key-sequence was not an escape sequence
             ;; and was shifted (and then mapped down to its unshifted form).
             (memq 'shift (event-modifiers (aref keys 0)))))))
    (unless mark-active
      (push-mark-command nil t))
    (setq cua--last-region-shifted t)
    (setq cua--explicit-region-start nil))

   ;; Set mark if user explicitly said to do so
   ((or cua--explicit-region-start cua--rectangle)
    (unless mark-active
      (push-mark-command nil nil)))

   ;; Else clear mark after this command.
   (t
    ;; If we set mark-active to nil here, the region highlight will not be
    ;; removed by the direct_output_ commands.
    (setq deactivate-mark t)))

  ;; Detect extension of rectangles by mouse or other movement
  (setq cua--buffer-and-point-before-command
        (if cua--rectangle (cons (current-buffer) (point)))))
)

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (message "Current line is copied.")
       (list (line-beginning-position) (line-end-position)) ) ) ))
(defadvice kill-region (before slick-copy activate compile)
  "When called interactively with no active region, cut the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (message "Current line is cut.")
       (list (line-beginning-position) (line-end-position)) ) ) ))

;; frames
;(global-set-key (kbd "C-w")   'quit-window)
;(global-set-key (kbd "C-n")   'new-empty-buffer)
;(global-set-key (kbd "C-S-n") 'make-frame-command)
;(global-set-key (kbd "C-S-o") 'open-in-desktop)

