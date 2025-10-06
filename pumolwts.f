C---------------------------------------------------------------
C.....Molecular Weight of mixture. 
C.....By Felix Jegede  (AspenTech UK Ltd)  
C.....Date:  January 16th 1996
C---------------------------------------------------------------
      SUBROUTINE pumolwts(CMW,NMW,IFAIL)

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)

      PARAMETER  (MAXCOMP=2)

      DIMENSION  CMW(NMW)

      DIMENSION  AMW(MAXCOMP)
C
C..............................................................
C....Components:  Hydrogen, Nitrogen (in this order)
C..............................................................
      DATA  AMW  /2.0, 28.013/
 

       DO 10 I=1,NOCOMP
          CMW(i) = AMW(i)
   10  CONTINUE

      RETURN
      END

