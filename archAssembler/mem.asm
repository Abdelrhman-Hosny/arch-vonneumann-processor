.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address

PUSH R1      #SP=FFFFFFFC,M[FFFFFFFE]=5
PUSH R2      #SP=FFFFFFFA,M[FFFFFFFC]=19
POP R1       #SP=FFFFFFFC,R1=19
POP R2       #SP=FFFFFFFE,R2=5