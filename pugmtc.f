
       SUBROUTINE pUgMTC (TG, P, C, NOCOMP, Z, Vg, NL, MTCS, NMC, IFAIL)
       IMPLICIT DOUBLE PRECISION (A-H,O-Z)
       PARAMETER  (MAXCOMP=2)

       DOUBLE PRECISION MTCS

       DIMENSION C(NOCOMP), MTCS(NOCOMP), DK(MAXCOMP)

C....Components:  H2, N2 (in this order)

       DATA DK /2.95, 2.95/  

C.....Original Coefficient = 3 [Bar/S]
C.....But adsim expects mtc in kg/m3/sec

       DO 10 I = 1, NOCOMP
         MTCS(i)  =  DK(i)/P
         MTCS(i)  =  MTCS(i)*720.0D0
10     CONTINUE


       RETURN
       END
