with RP.Clock;
with USB.Serial;

procedure Demo is
   --  Crystal oscillator frequency
   XOSC_Frequency : constant RP.Clock.XOSC_Hertz := 12_000_000;
begin
   RP.Clock.Initialize (XOSC_Frequency);  -- set sys clock to 125MHz
   USB.Serial.Initialize;

   loop
      USB.Serial.Process;
   end loop;
end Demo;
