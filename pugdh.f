
      SUBROUTINE pUgDH ( T, P, W, n2, C, NOCOMP, IP, n3, n4, layerid,
     & DH, NHADS, IFAIL)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)

      PARAMETER  (MAXCOMP=2)
      INTEGER          N3,N4,LayerID,NHADS,IFail,i
      DOUBLE PRECISION IP(n2,n3)

      DIMENSION W(NOCOMP), DH(NOCOMP), Doi(MAXCOMP), C(NOCOMP)

C..............................................................
C.....Components:  H2, N2 (in this order)
C..............................................................
      DATA Doi /-7.14D3, -2.1D4/

C......MJ/KMOL
      DO 10 I = 1,NOCOMP
        DH(i)  = Doi(i)*1.0d-3
10    CONTINUE

      RETURN
      END

