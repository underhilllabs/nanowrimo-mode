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
  :group 'comm)

(defcustom nanowrimo-api-token "username:hexstring"
  "Your NaNoWriMo API token that can be found at: https://nanowrimo.org/api/wordcount"
  :group 'nanowrimo
  :type 'string)

(defcustom nanowrimo-username ""
  "Your NaNoWriMo Username"
  :group 'nanowrimo
  :type 'string)

(provide 'nanowrimo)
