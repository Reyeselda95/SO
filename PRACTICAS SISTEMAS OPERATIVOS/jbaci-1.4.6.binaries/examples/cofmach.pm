{ C.Eng 534 Final Exam Question 1 .. January 17, 1991

  An  automated coffee machine is controlled by a chip which runs two
  processes.  One process accepts money and keeps track of the amount
  paid,  and  the  other  delivers  the product and the change when a 
  sufficient amount of money  has  been  entered  and  the  machine's
  button  is  pushed. When  an  insufficient amount of money has been
  entered , or  when  no  products remain in the machine, the machine
  should return no product  and  it  should  return  the  full amount
  deposited.  Implement   the   two  processes  using  the  Ben-Ari's
  concurrent Pascal kit.  

}
program coffee_machine;

const  no_of_cups    = 5;
       price_per_cup = 5;

var    cup_counter    : integer;
       coins_inserted : integer;
       button_pressed : semaphore:=0;
       accept_coin    : semaphore:=1;

procedure accept_coins;
var new_coin : integer;
begin
   while cup_counter > 0 do 
     begin
        wait(accept_coin);
        writeln('Ready to accept coins'); coins_inserted:= 0; new_coin:= 0;
        while new_coin >= 0 do
           begin
              write('Enter coin (A negative quantity is press button) = ');
              read(new_coin); writeln;
              if new_coin > 0 
                 then coins_inserted:= coins_inserted + new_coin;  
           end;
        signal(button_pressed); 
     end;
   writeln('No more free cups .. machine out of order');
end;

procedure pour_coffee;
var coins_returned : integer;
begin
   while cup_counter > 0 do 
     begin
        wait(button_pressed);
        if coins_inserted >= price_per_cup
           then begin
                   cup_counter := cup_counter-1;        
                   write('Please take your coffee');
                   coins_returned := coins_inserted - price_per_cup; 
                   if coins_returned > 0
                      then writeln(' .. coins returned = ',coins_returned)
                      else writeln;
                end
           else writeln('Insufficient amount of coins .. coins returned = ',
                        coins_inserted);
        signal(accept_coin);
     end;
end;

begin
   cup_counter := no_of_cups;
   cobegin accept_coins; pour_coffee; coend;
end.