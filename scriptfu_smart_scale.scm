(script-fu-register
    "script-fu-smart-scale"
    "Smart Scale Image"
    "Scales and resizes an image to specific measures."
    "Finn Pauls <ich@finnpauls.de>"
    "MIT License"
    "June 13, 2011"
    "RGB*"
    SF-IMAGE    "Image"  0
    SF-DRAWABLE "Drawable"  0
    SF-ADJUSTMENT  "New Image Width"     '(99 1 500 1 1 0 1) ;inScaleWidth
    SF-ADJUSTMENT  "New Image Height"     '(64 1 500 1 1 0 1) ;inScaleHeight

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
        (gimp-layer-resize-to-image-size inDrawable)
    )
    (gimp-image-undo-group-end inImage)
)
