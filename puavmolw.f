C---------------------------------------------------------------
C.....Molecular Weight of mixture. 
C.....By Felix Jegede  (AspenTech UK Ltd)  
C.....Date:  January 16th 1996
C---------------------------------------------------------------
      SUBROUTINE pUAvMolW (Y,NOCOMP, GMW,IFAIL)

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)

      PARAMETER  (MAXCOMP=2)

      DIMENSION  Y(NOCOMP)

      DIMENSION  AMW(MAXCOMP)
C
C..............................................................
C....Components:  Hydrogen, Nitrogen (in this order)
C..............................................................
      DATA  AMW  /2.0, 28.013/
 
       GMW = 0.0D0
       DO 10 I=1,NOCOMP
          GMW =  GMW + Y(i)*AMW(i)
   10  CONTINUE

      RETURN
      END

