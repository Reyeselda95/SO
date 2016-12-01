{ Ceng 534 Operating Systems Midterm Question 1  ...  December 4, 1990

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

const  limit = 5;

var no_vehicles  : integer;    {in tunnel}
    red          : boolean;    {traffic light}
    screen       : semaphore;  {controls screen display mutex}
    i            : integer;
    max          : integer;

procedure entrance;
var entry_counter :integer;
begin
   while true do
     begin
        if not red
           then begin
                   entry_counter:= random(max);   
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

procedure exit;
var exit_counter :integer;
begin
   while true do
     begin
        exit_counter:= random(no_vehicles);
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
   no_vehicles := 0; max:= limit*2; red:= false; initialsem(screen,1);
   cobegin lights; entrance; exit coend;
end.