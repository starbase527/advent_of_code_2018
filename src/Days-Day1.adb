
with Ada.Containers;
with Ada.Containers.Hashed_Sets;

separate(Days)

procedure Day1 (Final_Freq       : out Frequency;
                Calibration_Freq : out Frequency) is

   function Frequency_Hash (F : Frequency) return Ada.Containers.Hash_Type is
   begin
      return Ada.Containers.Hash_Type (abs F);
   end Frequency_Hash;

   function Equivalent_Frequencies (Left, Right : Frequency) return Boolean is
   begin
      return Left = Right;
   end Equivalent_Frequencies;

   package FS is new Ada.Containers.Hashed_Sets
     (Element_Type        => Frequency,
      Hash                => Frequency_Hash,
      Equivalent_Elements => Equivalent_Frequencies);

   type Maybe_Frequency (Valid : Boolean := False) is
      record
         case Valid is
            when True => Value : Frequency;
            when False => null;
         end case;
      end record;

   Input : File_Type;

   Freq         : Frequency := 0;
   Freqs        : FS.Set;
   First_Repeat : Maybe_Frequency := (Valid => False);

   procedure Update_Freq is
   begin
      Freq := Freq + Frequency'Value (Get_Line (Input));

      if not Freqs.Contains (Item => Freq) then
         Freqs.Insert (New_Item => Freq);
      elsif not First_Repeat.Valid then
         First_Repeat := (Valid => True, Value => Freq);
      end if;
   end Update_Freq;

begin

   Open (File => Input,
         Mode => In_File,
         Name => "inputs/day1.txt");

   Freqs.Clear;
   Freqs.Insert (Freq);

   while not End_Of_File (Input) loop
      Update_Freq;
   end loop;
   Final_Freq := Freq;

   while not First_Repeat.Valid loop
      if End_Of_File (Input) then
         Reset (Input);
      end if;
      Update_Freq;
   end loop;

   if First_Repeat.Valid then
      Calibration_Freq := First_Repeat.Value;
   else
      Put_Line ("Day1 Error: No repeated frequency");
   end if;

   Close (Input);

end;
