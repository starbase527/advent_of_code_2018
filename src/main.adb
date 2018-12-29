
with Days;    use Days;
with Text_IO; use Text_IO;

procedure Main is

begin

   declare
      Final_Freq, Calibration_Freq : Frequency := Frequency'Invalid_Value;
   begin
      Day1 (Final_Freq, Calibration_Freq);
      Put_Line ("Day 1:");
      Put_Line (ASCII.HT & "Final Frequency: " & Final_Freq'Image);
      Put_Line (ASCII.HT & "Calibration Frequency: " & Calibration_Freq'Image);
   end;

   declare
      Checksum : Warehouse_Checksum := Warehouse_Checksum'Invalid_Value;
      Common   : String := Day2 (Checksum);
   begin
      Put_Line ("Day 2:");
      Put_Line (ASCII.HT & "Warehouse checksum: " & Checksum'Image);
      Put_Line (ASCII.HT & "Common: " & Common);
   end;

   declare
      Conflict_Fabric : Fabric_Extent := Fabric_Extent'Invalid_Value;
      Safe_Claim      : Positive;
   begin
      Conflict_Fabric := Day3 (Safe_Claim);
      Put_Line ("Day 3:");
      Put_Line (ASCII.HT & "Conflicting claims on " & Conflict_Fabric'Image
                & " square inches of the fabric.");
      Put_Line (ASCII.HT & "Safe claim: " & Safe_Claim'Image);
   end;

end Main;
