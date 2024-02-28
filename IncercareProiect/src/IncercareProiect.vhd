
---------------------------------------------------------------------------------------------------
--
-- Title       : IncercareProiect
-- Design      : IncercareProiect
-- Author      : alexandru_ivan91@yahoo.com
-- Company     : @student.utcluj.ro
--
---------------------------------------------------------------------------------------------------
--
-- File        : IncercareProiect.vhd
-- Generated   : Fri May 20 18:14:37 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {IncercareProiect} architecture {IncercareProiect}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity IncercareProiect is	
 port (	CLK : in std_logic; 
 Reset : in std_logic; 
 Bilete: in std_logic_vector (3 downto 0);
 Distanta: in std_logic_vector(6 downto 0);
 CostBilet: out std_logic_vector(6 downto 0); 
 SumaIntrodusa : out std_logic_vector(6 downto 0); 
 EliberareRest: out std_logic;
 EliberareBilet: out std_logic;		 
 CasaDeBani:  in std_logic_vector(6 downto 0);	
 LipsaRest: out std_logic;
 LipsaBilete: out std_logic;
 BileteOut : out  std_logic_vector (3 downto 0);
 Bancnota: in std_logic_vector(6 downto 0);
 Moneda: in std_logic_vector(6 downto 0) ; 
 SumaInsuficienta: out std_logic);
 
 
 
 
	 
 
end IncercareProiect;

--}} End of automatically maintained section

architecture IncercareProiect of IncercareProiect is  
type state_type is (Asteptare,
StareBilete,
IntroducetiDistanta,
IntroducetiBancnote,
IntroducetiMonede,
Calculare,
Rest,

Bilet);	  
signal current_state,next_state,bilete_state: state_type;
signal AuxCostBilet: std_logic_vector (6 downto 0);   
signal AuxSumaIntrodusa: std_logic_vector (6 downto 0);	  
signal AuxBilete: std_logic_vector (3 downto 0);
signal ProvizoriuBilete: Std_logic_vector (3 downto 0);

begin		  
	
  process (CLK, Reset,Bilete) 
  begin
	  if(Reset = '1') then 
		
 current_state <= Asteptare;
 else if (Bilete ="0000") then
	
	 current_state<=StareBilete;
 
 elsif(CLK'event and CLK = '1') then
 current_state <= next_state;
 end if;	
 end if;
 end process;
 
 ProvizoriuBilete <=Bilete ;

 
	
process (current_state, Bancnota, Moneda, Distanta, CasaDeBani)	
	
begin 		 	
	 
   	AuxBilete <=ProvizoriuBilete;
	   BileteOut <= AuxBilete;
 AuxSumaIntrodusa <="0000000";EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; SumaInsuficienta<='0';
 case current_state is	
	 when StareBilete => LipsaBilete <='1';	
	  next_state <=Asteptare;
	 when Asteptare => AuxCostBilet <="0000000"; AuxSumaIntrodusa <="0000000";EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0'	;
	 next_state<=IntroducetiDistanta;
	 when 	IntroducetiDistanta => 
	 if (Distanta > "1010000" ) then
	AuxCostBilet <="0101000"; AuxSumaIntrodusa <="0000000";EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0'	;	 
	 else if(Distanta > "0111100" ) then 
	AuxCostBilet <="0101000"; AuxSumaIntrodusa <="0000000";EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0'	;
	 else if (Distanta > "0101000") then
	AuxCostBilet <="0011110"; AuxSumaIntrodusa <="0000000";EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0'	;
	 else if  (Distanta > "0010100") then
	AuxCostBilet <="0010100"; AuxSumaIntrodusa <="0000000";EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0'	;
	else if (Distanta > "0000000") then 
	AuxCostBilet <="0001010"; AuxSumaIntrodusa <="0000000";EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0'	;
		end if;	
	end if;
	end if	;
	end if ;
	end if;	 
	   
	
	next_state <= IntroducetiBancnote;
	when IntroducetiBancnote =>
 CostBilet <= AuxCostBilet;	 AuxSumaIntrodusa <=Bancnota ;EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0'; 
	next_state <=IntroducetiMonede;
	when IntroducetiMonede =>
	 AuxSumaIntrodusa <=Bancnota + Moneda ;EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0'; 
	
	next_state <= Calculare;
	when Calculare => 
	if (AuxCostBilet < AuxSumaIntrodusa )then
	 AuxSumaIntrodusa <=Bancnota + Moneda ;EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0';
	next_state <=  Rest;  
	else if (AuxCostBilet = AuxSumaIntrodusa ) then
		AuxSumaIntrodusa <=Bancnota + Moneda ;EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0';
		next_state <= Bilet;
	else if (AuxCostBilet > AuxSumaIntrodusa) then
	AuxSumaIntrodusa <=Bancnota + Moneda ;EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='1';
	next_state <=IntroducetiBancnote;
	end if;
	end if;	   
	end if;
	SumaIntrodusa<=AuxSumaIntrodusa;  
	when Rest =>
	if   ((CasaDeBani) > (AuxSumaIntrodusa - AuxCostBilet)) then 
	 CostBilet <= AuxCostBilet;AuxSumaIntrodusa <=Bancnota + Moneda ;EliberareRest<='1'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0';	
	
	next_state<= Bilet;	 
	
	else if   ((CasaDeBani) = (AuxSumaIntrodusa - AuxCostBilet)) then 
	 CostBilet <= AuxCostBilet;AuxSumaIntrodusa <=Bancnota + Moneda ;EliberareRest<='1'; EliberareBilet<='0'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0';
	next_state<= Bilet;	  
	else if ( CasaDeBani < (AuxSumaIntrodusa - AuxCostBilet))		then
	AuxSumaIntrodusa <=Bancnota + Moneda ;EliberareRest<='0'; EliberareBilet<='0'; LipsaRest <='1'; LipsaBilete<='0'; SumaInsuficienta<='0';
	next_state <= Bilet;
	end if;
	end if;	 
	end if;

	when Bilet =>
	CostBilet <="0000000" ; SumaIntrodusa <="0000000" ;EliberareRest<='0'; EliberareBilet<='1'; LipsaRest <='0'; LipsaBilete<='0'; SumaInsuficienta<='0';
	

	next_state<=Asteptare ;	 

 end case; 
end process;


end IncercareProiect;
