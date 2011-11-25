# shobon.l

2ch software板のxyzzyスレその12の809に色々付け足した物です(｀･ω･´)

## original

http://pc12.2ch.net/test/read.cgi/software/1226425897/809

    名無しさん＠お腹いっぱい。<>sage<>2010/07/13(火) 00:54:33 ID:5ZaMoH/b0
     (setq *print-circle* t)
     (setq shobobon '("( 　 　´)""(　　 ´･)""(　 ´･ω)""(　´･ω･)"
               "(´･ω･｀)""(･ω･｀　)""(ω･｀ 　)""(･｀ 　　)"
               "(｀ 　 　)""( 　　　 )" ))
     (setf (cdr (last shobobon)) shobobon)
      
     ;; setf を setq にするとエラーが出る。なんで？
     ;; ググッても違いが分からん。
      
     (defun shobon ()
       "(´･ω･｀)ｼｮﾎﾞｰﾝ"
       (interactive)
       (loop
         (when(read-char-no-hang *keyboard*)(return))
         (sit-for 0.1)
         (setq shobobon (cdr shobobon)) (minibuffer-prompt "~A" (car shobobon))))
     
     M-x shobon

