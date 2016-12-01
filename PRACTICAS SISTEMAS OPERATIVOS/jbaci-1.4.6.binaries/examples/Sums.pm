{ Midterm 1, Nov. 15, 1995, Question 2: m1_q2_95.cp
  
  Write down a concurrent Pascal program to compute the sum of N 
  numbers using the following algorithm: A set of k processes each
  has access to the entire set of numbers. A process removes two 
  numbers, adds them and returns the result to the set. When there
  is only one number in the set, the program terminates and returns
  that value.

}
program sum_of_N_numbers;

const   N=10;
        k=4;
var     i        :integer;
        list     :array[1..N] of integer;
        ptr      :integer;
        count    :integer;
        mutex    :semaphore;
        add      :semaphore;
        finished :semaphore;

procedure adder(m:integer);
var     num_1   :integer;
        num_2   :integer;
begin
   while true do
      begin
         wait(add);     {Wait for a two-numbers-ready signal}
         wait(mutex);   {Get the topmost two numbers}
            num_1:=list[ptr]; list[ptr]:=-1; ptr:=ptr+1;
            num_2:=list[ptr]; list[ptr]:=-1; ptr:=ptr+1; 
            count:=count-2;
            writeln(' m: ',m,' ptr: ',ptr,' (',num_1,' + ',num_2,') count: ',count);
         signal(mutex);        
         num_1:=num_1+num_2; {Add}
         wait(mutex);        {Put the sum back}
            ptr:=ptr-1; list[ptr]:=num_1; 
            count:=count+1;
            write('*m: ',m,' ptr: ',ptr,' count: ',count,' (');
            for i:= 1 to N do write(list[i],' '); writeln(')');
         signal(mutex);
         signal(finished); {Announce that one addition is over}
      end;
end;

procedure adder_control;
var   i       :integer;
      adders  :integer;
begin
   adders:=0; {All adders are ready}
   for i:= 1 to k do begin adders:=adders+1; signal(add); end;

   while true do
      begin
         wait(finished); {Wait for a finished signal}
         adders:=adders-1;         
         if adders = 0 then 
            if count=1  {if one value is left and no active adders STOP}
               then begin writeln('Sum is : ',list[ptr]); end
               else begin adders:=adders+1; signal(add); end; 
      end;
end;

begin {main}
   for i:= 1 to N do list[i]:= i; {initialize list}
   for i:= 1 to N do write(list[i],' '); writeln;

   initialsem(mutex,1);   initialsem(add,0);   initialsem(finished,0);
   ptr:=1;     count:=N; 

   cobegin adder(1); adder(2); adder(3); adder(4); adder_control; coend; 
end.

