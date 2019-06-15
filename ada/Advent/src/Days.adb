
package body Days is

   procedure Day1 (Final_Freq       : out Frequency;
                   Calibration_Freq : out Frequency) is separate;

   function Day2 (Checksum : out Warehouse_Checksum) return String is separate;

   function Day3 (Safe_Claim : out Positive) return Fabric_Extent is separate;

   procedure Day4 (Guard_Asleep_Longest : out GuardID;
                   Minute_Most_Asleep   : out Ada.Calendar.Formatting.Minute_Number) is separate;

end Days;
