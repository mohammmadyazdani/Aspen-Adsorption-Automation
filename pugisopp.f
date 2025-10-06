
      SUBROUTINE pUgIsoPp(TG,P,Y,NOCOMP,AIP,n1,n2,n3,Ws,nws,IFAIL)
      IMPLICIT DOUBLE PRECISION (A-H,O-Z)
      PARAMETER  (MAXCOMP=2)

      DIMENSION Y(NOCOMP),Ws(NOCOMP)
      DIMENSION A1(MAXCOMP), DH(MAXCOMP), Qoi(MAXCOMP),
     &          B1(MAXCOMP),BB(MAXCOMP),AIP(n1,n2)

C..............................................................
C.....Molecular sieve
C.....Components:  H2, N2 (in this order)
C..............................................................
C....A1 kmol/kg/bar  [from: Ncm3/g/bar (X*1e-3/22.4) ]
C....DH j/mol (adsorption enthalpy)
C....B1 /bar

      DATA A1 /1.5625d-5, 4.4643d-4/
      DATA DH /7.14D3, 2.1D4/
      DATA B1 /0.0, 0.160D0/

      R  = 0.0831441
      RR = 8.32

c....Total pressure (Bar )
      Pt = P

      SUMB = 0.0D0
      DO 10 I = 1, NOCOMP

C......Constant qo (Kmol/Kg)  A1 kmol/kg/bar 
        Qoi(i) = A1(i)*Y(i)*PT*DEXP( (DH(i)/RR) * (1.0/TG - 1.0/293.0)) 

C.....Constant BB (-), b1 (1/bar)
        BB(i) = B1(i)*Y(i)*PT*DEXP( (DH(i)/RR) * (1.0/TG - 1.0/293.0) )    

        SUMB  = SUMB + BB(i) 
10    CONTINUE

C.....Total Ws in Kmol/Kg
      DO 11 I = 1, NOCOMP
        Ws(i) = Qoi(i)/(1.0 + SUMB)
11    CONTINUE

      RETURN
      END
