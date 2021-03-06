# ! / u s r / b i n / p e r l 
 u s e   D B I ; 
 u s e   D B D : : m y s q l ; 
 u s e   I O : : H a n d l e ; 


#   Taha Al-jumaily
#
#  Create tables (human)
#
#


 $ d b h   =   D B I   - >   c o n n e c t   ( ' D B I : m y s q l :DataBaseName' ,   ' username' ,   ' password ' )   o r   d i e   " C o u l d   n o t   c o n n e c t   t o   d a t a b a s e :   $ D B I : : e r r s t r " ; 
 
 m y   $ l n = s h i f t ; 
 i f ( ! $ l n   o r   $ l n   e q   " " ) {   p r i n t   " E n t e r   L N   N a m e ,   e x i t i n g & \ n " ;   e x i t ;   } 
 
 #   C h r o m o s o m e s 
 @ c h r o m o = ( ) ; 
 f o r ( $ i = 1 ; $ i < 2 3 ; $ i + + ) {   p u s h ( @ c h r o m o , $ i ) ;   }   p u s h ( @ c h r o m o , ( ' X ' , ' Y ' ) ) ;   # 2 3 
 
 $ p a i r e d _ m a t c h e s = 1 ;               #   P a i r e d _ m a t c h e s 
 $ r e a d _ t b l   =   " Y F M _ L N " . $ l n ; 
   
       
 #   - - - - -   C h r o m o s o m e s   - - - - - - 
 f o r e a c h   $ c h r   ( @ c h r o m o [ 0 . . $ # c h r o m o ] ) { 
       $ c o l = $ c h r . " _ c h r " ; 
       $ i = 1 ; 
       
       $ t b l n a m e = " L N " . $ l n . " _ P M 1 _ " . $ c o l ; 
       $ c r e a t e   =   " C R E A T E   T A B L E   ` $ t b l n a m e `   (   ` i d `   i n t ( 1 0 0 )   u n s i g n e d   N O T   N U L L   A U T O _ I N C R E M E N T , ` s t a r t x `   i n t ( 2 5 )   D E F A U L T   N U L L , P R I M A R Y   K E Y   ( ` i d ` ) )   E N G I N E = M y I S A M " ; 
       $ d b h - > d o ( " D R O P   T A B L E   I F   E X I S T S   ` $ t b l n a m e ` " ) ; 
       $ d b h - > d o ( $ c r e a t e ) ; 
         
       $ s t h   =   $ d b h - > p r e p a r e ( " S E L E C T   s t a r t x   F R O M   $ r e a d _ t b l   W H E R E   c h r o m o s o m e   L I K E   ' c h r $ c h r '   A N D   p a i r e d _ m a t c h e s = $ p a i r e d _ m a t c h e s " ) ; 
       $ s t h - > e x e c u t e ( ) ; 
       p r i n t   " \ n P r o c e s s i n g :   \ t L N : $ l n \ t C h r o m o s o m : $ c h r \ t R o w s :   " . $ s t h - > r o w s . " \ n " ;       
       w h i l e ( m y   $ r   =   $ s t h - > f e t c h r o w _ h a s h r e f ( ) ) { 
             #   p r o g r e s s   p e r c e n t a g e   b a r 
             s h o w _ p r o g r e s s ( $ i / $ s t h - > r o w s ) ; 
             $ d b h - > d o ( " I N S E R T   I N T O   $ t b l n a m e   ( s t a r t x )   V A L U E S   ( $ r - > { ' s t a r t x ' } ) " ) ; 
             $ i + + ; 
             } $ s t h - > f i n i s h ;     
       }       
 
 
 s u b   f l u s h {   m y   $ h   =   s e l e c t ( $ _ [ 0 ] ) ;   m y   $ a = $ | ;   $ | = 1 ;   $ | = $ a ;   s e l e c t ( $ h ) ;   } 
 s u b   s h o w _ p r o g r e s s   { 
       m y   ( $ p r o g r e s s )   =   @ _ ; 
       m y   $ p e r c e n t   =   i n t ( $ p r o g r e s s * 1 0 0 ) ; 
       $ p e r c e n t   =   $ p e r c e n t   > =   1 0 0   ?   ' d o n e . '   :   $ p e r c e n t . ' % ' ; 
       p r i n t ( " \ r   \ t   $ p e r c e n t " ) ; 
       f l u s h ( S T D O U T ) ; 
       } 
 
 p r i n t   " \ n " ; 
 $ d b h - > d i s c o n n e c t ; 
 e x i t ; 
