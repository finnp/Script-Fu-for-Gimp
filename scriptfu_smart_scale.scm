;Creative Commons Attribution Noncommercial Share Alike (cc-by-nc-sa), Finn Pauls <ich@finnpauls.de>
;
;This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 
;To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to
;Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.


(script-fu-register
    "script-fu-smart-scale"
    "Smart Scale Image"
    "Scales and resizes an image to specific measures."
    "Finn Pauls <ich@finnpauls.de>"
    "Creative Commons Attribution Noncommercial Share Alike (cc-by-nc-sa) Finn Pauls"
    "June 13, 2011"
    "RGB*"
    SF-IMAGE    "Image"  0
    SF-DRAWABLE "Drawable"  0
    SF-ADJUSTMENT  "New Image Width"     '(150 1 500 1 1 0 1) ;inScaleWidth
    SF-ADJUSTMENT  "New Image Height"     '(70 1 500 1 1 0 1) ;inScaleHeight

)
(script-fu-menu-register "script-fu-smart-scale" "<Image>/Image")
(define (script-fu-smart-scale inImage inDrawable inScaleWidth inScaleHeight)
    (gimp-image-undo-group-start inImage)
    (let*
        (
            (ImageWidth (car(gimp-image-width inImage)))
            (ImageHeight (car(gimp-image-height inImage)))
            (ImageRatio (/ ImageWidth ImageHeight))
            (ImageSuitableWidth (round (* inScaleHeight ImageRatio)))
            (ImageSuitableHeight (round (/ inScaleWidth ImageRatio))) 
            (OffsetWidth 0)
            (OffsetHeight 0)
        )
        
        (if (< ImageRatio (/ inScaleWidth inScaleHeight))
            (begin 
            (gimp-image-scale inImage inScaleWidth ImageSuitableHeight)
            (set! OffsetHeight (round (/ (- inScaleHeight ImageSuitableHeight) 2))))
            (begin  ;else
            (gimp-image-scale inImage ImageSuitableWidth inScaleHeight)
            (set! OffsetWidth (round (/ (- inScaleWidth ImageSuitableWidth) 2))))
        )
        (gimp-image-resize inImage inScaleWidth inScaleHeight OffsetWidth OffsetHeight)
    )
    (gimp-image-undo-group-end inImage)
)

