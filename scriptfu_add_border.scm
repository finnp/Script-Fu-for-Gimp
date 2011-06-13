;Creative Commons Attribution Noncommercial Share Alike (cc-by-nc-sa), Finn Pauls <ich@finnpauls.de>
;
;This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 
;To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to
;Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.


(script-fu-register
    "script-fu-add-bicolored-frame"
    "Add bicoloured Frame"
    "Creates a two-colored frame."
    "Finn Pauls <ich@finnpauls.de>"
    "Creative Commons Attribution Noncommercial Share Alike (cc-by-nc-sa) Finn Pauls"
    "May 15, 2011"
    "RGB*"
    SF-IMAGE    "Image"  0
    SF-DRAWABLE "Drawable"  0
    SF-COLOR  "Color of inner border"         '(255 255 255)   ;inFirstBorderColor
    SF-COLOR  "Color of outer border"         '(172 172 172)   ;inSecondBorderColor
    SF-ADJUSTMENT  "Width of inner border"     '(2 1 500 1 1 0 1) ;inFirstBorderSize
    SF-ADJUSTMENT  "Width of outer border"     '(1 1 500 1 1 0 1) ;inSecondBorderSize
)
(script-fu-menu-register "script-fu-add-bicolored-frame" "<Image>/Filters/Decor")
(define (script-fu-add-bicolored-frame inImage inDrawable inFirstBorderColor inSecondBorderColor inFirstBorderSize inSecondBorderSize)
    ;Group actions
    (gimp-image-undo-group-start inImage)
    ; Add borders
    (let*
        (
            (ImageWidth (car(gimp-image-width inImage)))
            (ImageHeight (car(gimp-image-height inImage)))
            (FirstBorderWidth (+ ImageWidth  (* inFirstBorderSize 2)))
            (FirstBorderHeight (+ ImageHeight  (* inFirstBorderSize 2)))
            (SecondBorderWidth (+ FirstBorderWidth (* inSecondBorderSize 2)))
            (SecondBorderHeight (+ FirstBorderHeight (* inSecondBorderSize 2)))
            (FirstBorderLayer
                     (car
                          (gimp-layer-new
                           inImage
                           FirstBorderWidth
                           FirstBorderHeight
                           RGB-IMAGE
                           "First Border"
                           100
                           NORMAL
                          )
                      )
            )
           (SecondBorderLayer
                     (car
                          (gimp-layer-new
                           inImage
                           SecondBorderWidth
                           SecondBorderHeight
                           RGB-IMAGE
                           "Frame"
                           100
                           NORMAL
                          )
                      )
            )
        )
        ;Add Inner Border
        (gimp-selection-all inImage)
        (gimp-image-resize inImage FirstBorderWidth FirstBorderHeight inFirstBorderSize inFirstBorderSize)
        (gimp-context-set-foreground inFirstBorderColor)
        (gimp-image-add-layer inImage FirstBorderLayer 1)
        (gimp-drawable-fill FirstBorderLayer 0)
        ;Add Outer Border
        (gimp-selection-all inImage)
        (gimp-image-resize inImage SecondBorderWidth SecondBorderHeight inSecondBorderSize inSecondBorderSize)
        (gimp-context-set-foreground inSecondBorderColor)
        (gimp-image-add-layer inImage SecondBorderLayer 2)
        (gimp-drawable-fill SecondBorderLayer 0)
        ;Clean it up
        (gimp-selection-all inImage)
	(gimp-image-undo-group-end inImage)
    
    )
)

