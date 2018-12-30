
with Days;    use Days;
with Text_IO; use Text_IO;
with Ada.Calendar.Formatting;

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

   declare
      Guard_Asleep_Longest : GuardID;
      Most_Asleep_Minute   : Ada.Calendar.Formatting.Minute_Number;
      type Guard_Minute_ID is range
        GuardID'First * Ada.Calendar.Formatting.Minute_Number'First
          .. GuardID'Last * Ada.Calendar.Formatting.Minute_Number'Last;
      GMI : Guard_Minute_ID;
   begin
      Day4 (Guard_Asleep_Longest, Most_Asleep_Minute);
      GMI := Guard_Minute_ID (Guard_Asleep_Longest * Most_Asleep_Minute);
      Put_Line ("Day 4:");
      Put_Line ("ID of guard asleep most * minute most asleep: " & GMI'Image);
   end;

end Main;
