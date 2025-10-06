C---------------------------------------------------------------
C.....Viscosity of mixture. 
C.....By Felix Jegede  (AspenTech UK Ltd)  
C.....Date:  January 16th 1996
C---------------------------------------------------------------
      SUBROUTINE pUgVisc(Tg, P, Y,NC,VISCM,IFAIL)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      DIMENSION Y(NC)
      PARAMETER (MAXCOMP=2)
      DIMENSION VISA(MAXCOMP), VISB(MAXCOMP), VISC(MAXCOMP)

C....Components:  Hydrogen, Nitrogen (in this order)
      DATA  VISA   /13.82, 90.30/
      DATA  VISB   /5.39, 46.14/

      VISCM = 0.0D0
      DO 1 I = 1, NC
        DD1 =  VISA(I)*( 1.0/TG - 1.0/VISB(I) )
        VISC(I) = 10**DD1
        VISCM  = VISCM  + VISC(I)*Y(I)
1     CONTINUE

C...CONVERT FROM mNs/m2 to Ns/m2
       VISCM  = VISCM*1.0D-3

      RETURN
      END



