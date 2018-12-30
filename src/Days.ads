
with Text_IO; use Text_IO;
with Ada.Calendar.Formatting;

package Days is

   subtype Frequency is Integer;
   procedure Day1 (Final_Freq       : out Frequency;
                   Calibration_Freq : out Frequency);

   subtype Warehouse_Checksum is Integer;
   function Day2 (Checksum : out Warehouse_Checksum) return String;

   subtype Fabric_Extent is Integer range 0 .. 1000*1000;
   function Day3 (Safe_Claim : out Positive) return Fabric_Extent;

   subtype GuardID is Positive;
   procedure Day4 (Guard_Asleep_Longest : out GuardID;
                   Minute_Most_Asleep   : out Ada.Calendar.Formatting.Minute_Number);

end Days;
