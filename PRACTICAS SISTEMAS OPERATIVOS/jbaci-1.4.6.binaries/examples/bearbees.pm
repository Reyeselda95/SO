(*
The Bear and the Honeybees. Given are n honeybees and a hungry bear. They share a pot of honey.
The pot is initially empty; its capacity is H portions of honey. The bear sleeps until the pot is full,
then eats all the honey and goes back to sleep. Each bee repeatedly gathers one portion of honey and 
puts it in the pot; the bee who fills the pot awakens the bear.

Represent the bear and honeybees as processes and develop code that simulates their actions.
Use semaphores for synchronization. Show the declarations and initial values of all semaphores that you use.
*)

Program bear_and_bees;

const n           = 3; {three bees}
      h           = 7; {portions for pot}
var   i            : integer;
      pot          : integer;
      mutex        : semaphore:=1;
      potmutex     : semaphore:=1;
      bear_wakeup  : semaphore:=0;
      bee_fill_pot : semaphore:=h;

procedure eat;
var i : integer; begin for i:= 1 to random(50) do end;

procedure gather_honey;
var i : integer; begin for i:= 1 to random(15) do end;

procedure bee(i:integer);
begin
   repeat
     wait(bee_fill_pot);
     wait(mutex); writeln('bee : ',i,' is gathering honey '); signal(mutex);     
     gather_honey;
     wait(potmutex); if pot < h then pot:=pot+1; 
     wait(mutex); 
       writeln('bee : ',i,' is filling the pot which has ',pot,' portions now');
     signal(mutex);   
     if pot = h 
        then begin signal(bear_wakeup);
                   wait(mutex); 
                     writeln('bee : ',i,' is waking the bear up .. pot = ',pot);
                   signal(mutex)
             end;
     signal(potmutex);
   until false;
end;

procedure bear;
var j : integer;
begin
   repeat
     wait(mutex); writeln('bear is now sleeping'); signal(mutex);
     wait(bear_wakeup);
     wait(mutex); writeln('bear is now awake and is eating ',pot,' portions'); signal(mutex);
     pot:=0; eat;  
     for j:= 1 to h do signal(bee_fill_pot);  
   until false;
end;

begin {main}
   pot:= 0; 
   cobegin bee(1);bee(2); bee(3); bear coend;
end.

