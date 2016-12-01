{ mk_q1_90.cp 

 CEng 534 Makeup Exam Question 1 .. January 30, 1991

(The Cigarette Smoker's Problem).  Three smokers  are  represented by processes
S1,S2, and S3. Three vendors are represented by processes  V1, V2, and V3. Each
smoker requires tobacco, a wrapper, and a match to smoke;  when these resources
are available, the smoker smokes the cigarette to completion  and  then becomes
eligible to smoke again. S1 has tobacco, S2 has wrappers, and S3  has  matches.
V1 supplies tobacco and wrappers, V2  supplies  wrappers  and  matches, and  V3
supplies matches and tobacco. V1, V2, and  V3 operate in mutual exclusion; only
one of these processes can operate at a time and the next vendor cannot operate
until resources supplied by the previous vendor have been consumed by a smoker.
Implement the above problem using Ben-Ari's concurrent Pascal kit.

Who waits for what : S1 --> V2
                     S2 --> V3
                     S3 --> V1
}

program Cigarette_Smoker;

var mutex  : semaphore;  {mutual exclusion semaphore for vendors V1, V2 and V3}
    Vsem   : array[1..3] of semaphore;  {Vendors semaphores}
    Ssem   : array[1..3] of semaphore;  {Smokers semaphores}
    screen : semaphore;  {mutex semaphore for screen} 
    i      : integer;

procedure S(i :integer);
var j,k : integer;
begin
  j:= i+1; if j = 4 then j:= 1; {Which vendor to wait?}    
  while true do
    begin
      wait(screen); writeln('Smoker ',i,' is waiting for vendor ',j); signal(screen);
      wait(Vsem[j]);  {wait for respective vendor}
      wait(screen); writeln('Smoker ',i,' is  now  smoking'); signal(screen);
      for k := 1 to 100 do; {smoke}
      signal(Ssem[i]); {Smoking is over. Notify vendor}
      wait(screen); writeln('Smoker ',i,' has finished smoking'); signal(screen);  
    end;
end;
 
procedure V(i :integer);
var j : integer;
begin
  j:= i-1; if j = 0 then j:= 3; {Which smoker to serve?}
  while true do
    begin
      wait(mutex); {Only one vendor active at one time}
      wait(screen); writeln('         Vendor ',i,' is ready for smoker ',j); signal(screen);
      signal(Vsem[i]); {smoker can now smoke}
      wait(screen); writeln('         Smoker ',j,' can smoke now '); signal(screen); 
      wait(Ssem[j]);   {wait for a smoking-finished signal from smoker}
      signal(mutex);
    end;
end;

begin {Main}
  initialsem(mutex,1); initialsem(screen,1);
  for i:= 1 to 3 do begin initialsem(Vsem[i],0); initialsem(Ssem[i],0); end;
  cobegin S(1); S(2); S(3); V(1); V(2); V(3); coend;
end.

