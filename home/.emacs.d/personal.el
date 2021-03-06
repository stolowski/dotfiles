(defun grep-for-word-under-cursor(word path)
  "Search recursively for WORD under the cursor using ack-grep, starting at PATH"
  (interactive (list 
                (read-from-minibuffer "Pattern: " (current-word))
                (read-from-minibuffer "Path: " (file-name-directory (buffer-file-name)))
                ))
  (ack-grep word path)
  )

(defun occur-for-word-under-cursor(word)
  "Find all occurrences of WORD under cursor in current buffer, or all buffers if called with prefix argument"
  (interactive (list (read-from-minibuffer "Pattern: " (current-word))))
  (if current-prefix-arg
       (multi-occur-in-matching-buffers ".*" word)
       (occur word)
       )
  (occur-rename-buffer t)
  )


(defun get-above-char()
  "Get character from a line above"
  (let (
        (o)
        )
    (setq o (- (point) (line-beginning-position)))
    (save-excursion
      (if (> (line-number-at-pos) 1)
          (progn
            (forward-line -1)
            (forward-char o)
            (char-after)
            )
        )
      )
    )
  )

(defun copy-above-char()
  "Copy character from a line above"
  (interactive)
  (insert (get-above-char))
  )

(defun ack-grep(pattern path)
  "ack-grep files for pattern"
  (interactive "sPattern: \nsPath: ")
  (let (
        (name)
        )
    (setq name (generate-new-buffer-name (concat "* ack-grep: " pattern)))
    (save-excursion
      (switch-to-buffer name)
      (shell-command (concat "ack-grep -i " pattern " " path) name nil)
      (goto-char (point-min))
      (insert (concat "-*- mode: grep; default-directory: \"" path "\" -*-"))
      (newline)
      (grep-mode)
      )
    )
  )

(defun isupper(c)
  "Check if character is uppercase. Returns nil or t"
  (if (< (upcase c) c) nil t)
  )

(defun header-guard-create(filename prefix)
  "Generate C/C++ header guard"
  (let (
        (value)
        (prevcase)
        (i)
        )
    (setq prevcase (isupper (elt filename 0)))
    (setq value (upcase (string (elt filename 0))))
    (setq i 1)
    (while (< i (length filename))
      (let (
            (elm)
            (newcase)
            )
        (setq elm (elt filename i))
        (setq newcase (isupper elm))
        (if (= elm ?.)
            (setq elm '?_)
          (if (and (eq newcase t)(not (eq newcase prevcase)))
              (setq value (concat value "_"))
            )
          )
        (setq value (concat value (upcase (string elm))))
        (setq prevcase newcase)
        (setq i (1+ i)))
      )
    (concat prefix "_" value)
    )
  )

(defun header-guard-insert(filename prefix)
  "Insert C/C++ header guard in current buffer"
  (interactive "BBuffer: \nsPrefix: ")
  (if (string= major-mode "c-mode")
      (let ((value))
        (setq value (header-guard-create filename prefix))
        (save-excursion
          (goto-char (point-min))
          (insert (concat "#ifndef " value))
          (newline)
          (insert (concat "#define " value))
          (newline 2)
          (goto-char (point-max))
          (newline)
          (insert (concat "#endif /* " value " */"))
          )
        )
    )
  )

(defun header-guard-insert-default()
  "Add C/C++ header guard using current buffer name and ACC prefix"
  (interactive)
  (header-guard-insert (buffer-name) "" )
  )

(defun filter-buffer(command)
  "Filter buffer contents through external command."
  (interactive)
  (save-excursion
        (shell-command-on-region (goto-char (point-min)) (goto-char (point-max)) command t))
)

(defun insert-include(word)
  "Insert #include <..> directive with given word"
  (interactive "sInclude filename: ")
  (save-excursion
    (let ((incltxt))
      (goto-char (point-min))
      (setq incltxt (concat "#include <" word ">"))
      (if (not (search-forward incltxt nil t))
          (progn
           (goto-char (point-min))
           (insert incltxt)
           (newline)
           )
        )
      )
    )
  )


(defun insert-include-from-word()
  "Insert #include <..> directive from word under cursor"
  (interactive)
  (insert-include (thing-at-point 'word))
)

;(defun header-guard()
;  "Add C/C++ header guard based on buffer file name."
;  (interactive)
;  (filter-buffer (concat '"~/.emacs.d/external/hdr_guard.py " buffer-file-name))
;)

(setq find-extensions '("*"))
(make-variable-buffer-local 'find-extensions)

(defun grep-by-extension(path expr)
  (interactive (list 
                (read-from-minibuffer "Path: " (file-name-directory (buffer-file-name)))
                (read-from-minibuffer "Pattern: " (current-word)))
               )
  (setq exts find-extensions)
  (find-grep (concat "find " path " -type f" 
                 (let (value)
                   (while exts
                     (setq value (concat value " -name '" (car exts) "'"))
                     (setq exts (cdr exts))
                     (if exts
                         (setq value (concat value " -or"))
                       )
                     )
                   value
                   )
                 " -exec grep -nH -e " expr " {} +"
                 )
         )
  )

(provide 'personal)
