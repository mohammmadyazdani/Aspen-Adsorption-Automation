C---------------------------------------------------------------
C.....Vapour Molar Specific Heat Capacity from correlation. 
C.....Data from Chem.Engg Vol6 JM Coulson & JF Richardson
C.....By Felix Jegede  (AspenTech UK Ltd)  
C.....Date:  January 16th 1996
C.....Modified by T. Brinkmann, 22.08.97
C.....MJ version
C.....Polynomials re formulated
C---------------------------------------------------------------

      SUBROUTINE pUgHCapMCv(T,P,Y,NOCOMP,Cv,IFAIL)

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)

      PARAMETER  (MAXCOMP=2)

      DIMENSION Y(NOCOMP)
      DIMENSION A(MAXCOMP),B(MAXCOMP),C(MAXCOMP),D(MAXCOMP)

C..............................................................
C....Components:  Hydrogen, Nitrogen (in this order)
C..............................................................
      DATA A / 27.143, 31.15000/  
      DATA B /  9.273d-3, -1.356D-2/ 
      DATA C / -1.380D-5, 2.6790D-5/ 
      DATA D / 7.645D-9, -1.168D-8/ 

      TD=273.15

       Cv = 0.0D0
       DO 10 I=1,NOCOMP
         HC = A(I) + T*(B(I) + T*(C(I) + D(I)*T))
         Cv  = Cv + Y(I)*HC
   10  CONTINUE

c......H = H*(T-TD)
       Cv = Cv*1.0d-3

      RETURN
      END


