      SUBROUTINE pUgEnthM (T,P,Y,NOCOMP,H,IFAIL)

      IMPLICIT DOUBLE PRECISION (A-H,O-Z)

      PARAMETER  (MAXCOMP=2)

      DIMENSION Y(NOCOMP)
      DIMENSION A(MAXCOMP),B(MAXCOMP),C(MAXCOMP),D(MAXCOMP)

C..............................................................
C.....Components:  H2, N2 (in this order)
C..............................................................
      DATA A / 27.143, 31.15000/  
      DATA B /  9.273d-3, -1.356D-2/ 
      DATA C / -1.380D-5, 2.6790D-5/ 
      DATA D / 7.645D-9, -1.168D-8/ 

      TD=273.15

       H = 0.0D0
       DO 10 I=1,NOCOMP
         HC = A(I) + T*(B(I) + T*(C(I) + D(I)*T))
         H  = H + Y(I)*HC
   10  CONTINUE

       H = H*(T-TD)*1.0d-3

      RETURN
      END

