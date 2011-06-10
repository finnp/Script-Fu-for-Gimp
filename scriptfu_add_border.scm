(script-fu-register
    "script-fu-add-border"
    "Go Ahead! Border"
    "Creates a two-colored border."
    "Finn Pauls, finnpauls.de"
    "This work is licensed under the Creative Commons Attribution-NonCommercial 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/3.0/ or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA."
    "May 15, 2011"
    "RGB*"
    SF-IMAGE    "Bild"  0
    SF-DRAWABLE "Drawable"  0
    SF-COLOR  "Farbe des innerer Rahmens"         '(255 255 255)   ;inFirstBorderColor
    SF-COLOR  "Farbe des zweiten Rahmens"         '(172 172 172)   ;inSecondBorderColor
    SF-ADJUSTMENT  "Breite des inneren Rahmens"     '(2 1 500 1 1 0 1) ;ininFirstBorderSize
    SF-ADJUSTMENT  "Breite des zweiten Rahmens"     '(1 1 500 1 1 0 1) ;ininSecondBorderSize
)
(script-fu-menu-register "script-fu-add-border" "<Image>/Filter/Decoration")
(define (script-fu-goahead-border inImage inDrawable inFirstBorderColor inSecondBorderColor inFirstBorderSize inSecondBorderSize)
    (let*
        (
            (ImageWidth (car(gimp-image-width inImage)))
            (ImageHeight (car(gimp-image-height inImage)))
            (FirstBorderWidth (+ ImageWidth  inFirstBorderSize inFirstBorderSize))
            (FirstBorderHeight (+ ImageHeight inFirstBorderSize inFirstBorderSize))
            (SecondBorderWidth (+ FirstBorderWidth inSecondBorderSize inSecondBorderSize))
            (SecondBorderHeight (+ FirstBorderHeight inSecondBorderSize inSecondBorderSize))
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
                           "Go Ahead Rahmen"
                           100
                           NORMAL
                          )
                      )
            )
        )
        ;Make it Smaller
        
        
        ;Add First Border
        (gimp-selection-all inImage)
        (gimp-image-resize inImage FirstBorderWidth FirstBorderHeight inFirstBorderSize inFirstBorderSize)
        (gimp-context-set-foreground inFirstBorderColor)
        (gimp-image-add-layer inImage FirstBorderLayer 1)
        (gimp-drawable-fill FirstBorderLayer 0)
        ;Add Second Border
        (gimp-selection-all inImage)
        (gimp-image-resize inImage SecondBorderWidth SecondBorderHeight inSecondBorderSize inSecondBorderSize)
        (gimp-context-set-foreground inSecondBorderColor)
        (gimp-image-add-layer inImage SecondBorderLayer 2)
        (gimp-drawable-fill SecondBorderLayer 0)
        ;Clean it up
        (gimp-selection-all inImage)
        ;Save it (Inactive)
        ;(gimp-file-save 0 inImage inDrawable "aktuell_xxxxxx.jpg" "aktuell_xxxxxx.jpg")
        
    )
)

