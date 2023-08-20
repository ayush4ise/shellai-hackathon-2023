/*********************************************
 * OPL 22.1.1.0 Model
 * Author: pkuma
 * Creation Date: Aug 19, 2023 at 4:42:12 PM
 *********************************************/
 //given data
 range origin = 1..2418; //locations of biomass places
 range depot = 1..2418; //possible depot places
 float forecast[origin] = ...; //forecasted supply from each place
 float distance[origin][depot] = ...; //distance matrix
 
 //variable
 dvar float+ biomass[origin][depot]; //how much is getting transported
 dvar boolean y_select[depot]; //to select if there should be a depot or not
 
 //objective function
 minimize
 (sum(i in origin, j in depot) distance[i][j]*biomass[i][j]) + (sum(j in depot) (25000 - (sum(i in depot) biomass[i][j]))*y_select[j]);
 
 //constraints
 subject to
 {
   sum(j in depot)y_select[j] <= 25; //total depots should be less than or equal to 25
   forall(j in depot)
     sum(i in origin) biomass[i][j] <= 25000*y_select[j]; //biomass supply to depot j should be less or equal to capacity
   
   forall(i in origin)
     0.8*forecast[i] <= sum(j in depot) biomass[i][j];
   forall(i in origin)
     sum(j in depot) biomass[i][j] <= forecast[i];
 }