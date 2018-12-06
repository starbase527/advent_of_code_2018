
with Text_IO; use Text_IO;

package Days is

   subtype Frequency is Integer;
   procedure Day1 (Final_Freq       : out Frequency;
                   Calibration_Freq : out Frequency);

   subtype Warehouse_Checksum is Integer;
   function Day2 (Checksum : out Warehouse_Checksum) return String;

   subtype Fabric_Extent is Integer range 0 .. 1000*1000;
   function Day3 return Fabric_Extent;

end Days;
