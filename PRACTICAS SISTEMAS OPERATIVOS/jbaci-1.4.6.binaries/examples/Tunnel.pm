{ m1_q1_90.cp

  Ceng 534 Operating Systems Midterm Question 1  ...  December 4, 1990

       A computer system is being used  to control the flow of traffic
  through a road tunnel. For safety  reasons, there must never be more
  than  approximately  N  vehicles  in the tunnel at one time. Traffic
  lights  at  the entrance control  the  entry  of traffic and vehicle
  detectors at entrance and exit are used to measure the traffic flow.
  
      An entrance process  records  all  vehicles entering the tunnel,
  and a separate exit process records all  vehicles  leaving. Each  of
  these processes can, at  any  time,  read  its  vehicle  detector to
  determine how many vehicles  have  passed since the last reading was
  made. A traffic lights process controls  the  traffic  lights at the
  entrance to the tunnel which are set to red whenever  the  number of
  vehicles in the tunnel equals or exceeds N, and green otherwise.
  
}
program tunnel;

const  limit = 5; {maximum number of vehicles in the tunnel}
       no_of_seeds = 100;

var no_vehicles  : integer;    {in tunnel}
    red          : boolean;    {traffic light}
    screen       : semaphore;  {controls screen display mutex}
    seed         : array[1..no_of_seeds] of integer;
    i            : integer;

function random(seed_no:integer;l_bound:integer;u_bound:integer) :integer;
var ran     :integer;
begin
   seed[seed_no]:=(seed[seed_no]*13077 + 6925) mod(32768);
   ran := (seed[seed_no] * 10000) div 32768;
   random := l_bound + ((u_bound - l_bound + 1) * ran) div 10000;
end;

procedure entrance;  {This procedure reads the entry detector}
var entry_counter :integer;
begin
   while true do
     begin
        if not red  
           then begin {light is GREEN .. new vehicles are are coming}
                   entry_counter:= random(1,0,limit*2);   {# of new vehicles}
                   no_vehicles:= no_vehicles + entry_counter;
                   wait(screen);
                   write(' Entry reading .. ',entry_counter);
                end
           else begin
                   wait(screen);
                   write(' Light is now RED ... ');
                end;
        writeln(' No of vehicles in tunnel .. ',no_vehicles);
        signal(screen);
    end;
end;

procedure exit; {This procedure reads the exit detector}
var exit_counter :integer;
begin
   while true do
     begin
        exit_counter:= random(2,0,no_vehicles);
        no_vehicles:= no_vehicles - exit_counter;
        wait(screen);
          writeln(' Vehicles passed .. ',exit_counter,
                  ' No of vehicles in tunnel .. ',no_vehicles);
        signal(screen);                  
     end;
end;

procedure lights;
begin
   while true do
     begin
        if no_vehicles >= limit then red:= true else red:= false;
        wait(screen);
          write(' Traffic light is .. '); 
          if red then writeln('RED') else writeln('GREEN');
        signal(screen);
    end; 
end;

begin {main}
   for i:= 1 to no_of_seeds do seed[i]:=6997*i;
   no_vehicles := 0; red:= false; initialsem(screen,1);
   cobegin lights; entrance; exit coend;
end.

