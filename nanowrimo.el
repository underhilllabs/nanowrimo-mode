;;; nanowrimo.el --- minor-mode for NaNoWriMo participants

;; Copyright (C) 2015
;; Bart Lantz <underhilllabs@gmail.com>

;; Author: Bart Lantz <underhilllabs@gmail.com>
;; URL: https://github.com/underhilllabs/nanowrimo-mode
;; Keywords: nanowrimo
;; Version: 0.1

;; This file is NOT part of Emacs

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This allows for posting word count of buffer to nanowrimo.org

;;; Usage:

;; Set nanowrimo-api-token which can be found at: https://nanowrimo.org/api/wordcount

;;; Code:



;;; Customisations:

(defgroup nanowrimo nil
  "nanowrimo minor-mode"
  :group 'editing)

(defcustom nanowrimo-api-token "username:hexstring"
  "Your NaNoWriMo API token that can be found at: https://nanowrimo.org/api/wordcount"
  :group 'nanowrimo
  :type 'string)

(defcustom nanowrimo-username ""
  "Your NaNoWriMo Username"
  :group 'nanowrimo
  :type 'string)

(defvar nanowrimo-mode nil
  "Mode for posting word-counts to Nanowrimo website.")

(make-variable-buffer-local 'nanowrimo-mode)

(defun nanowrimo-mode (&optional arg)
  "Nanowrimo minor mode"
  (interactive "P")
  (setq nanowrimo-mode
        (if (null arg)
            (not nanowrimo-mode)
          (> (prefix-numeric-value arg) 0)))
  (if nanowrimo-mode
      (add-hook 'after-change-functions 'nanowrimo)
    (remove-hook 'after-change-functions 'nanowrimo)))

(defun nanowrimo-hash (wc)
	"Creates the SHA-1 hash of username, api-token, wc for posting to the nanowrimo api"
	(if (and (boundp 'nanowrimo-username) (boundp 'nanowrimo-api-token)
					 (secure-hash 'SHA-1 (format t "~a~a~a" nanowrimo-username nanowrimo-api-token wc)))
			(message "Please define nanowrimo username and api token.")))

(defun nanowrimo-word-count () 
	"Count words in buffer" 
	(interactive)
	(shell-command-on-region 
	 (point-min) 
	 (point-max) 
	 "wc -w"))

(defun nanowrimo-post-word-count ()
	"Posts the buffers current word count to Nanowrimo API."
	(let ((nanowrimo-api-url "http://nanowrimo.org/api/wordcount")
				(nanowrimo-wc 0)
				(nanowrimo-hash ""))
		(setq nanowrimo-wc (nanowrimo-word-count))
		(setq nanowrimo-hash (nanowrimo-hash(wc)))
		(url-retrieve-synchronously (format t "~a/~a" nanowrimo-api-url nanowrimo-api-url nanowrimo-hash))))

(provide 'nanowrimo)
