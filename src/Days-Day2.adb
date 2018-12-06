
separate(Days)

function Day2 (Checksum : out Warehouse_Checksum) return String is

   package Warehouse_Box is

      type Box_ID_Symb is new Character range 'a' .. 'z';
      type Box_ID is array (1..26) of Box_ID_Symb;
      type Box_Symb_Count is array (Box_ID_Symb) of Integer range 0..Box_ID'Last;
      type Box_ID_Info is record
         ID     : Box_ID;
         Counts : Box_Symb_Count;
         Double,
         Triple : Boolean;
      end record;

      --        function To_String (BID : Box_ID) return String;
      function Get_Box (Input : File_Type) return Box_ID_Info;
      function Similar_IDs (Left, Right : Box_ID_Info;
                            Common      : out String) return Boolean;

   end Warehouse_Box;

   package body Warehouse_Box is

      --        function To_String (BID : Box_ID) return String is
      --           ID : String (Box_ID'Range);
      --        begin
      --           for I in Box_ID'Range loop
      --              ID (I) := Character (BID (I));
      --           end loop;
      --           return ID;
      --        end To_String;

      function Get_Box (Input : File_Type) return Box_ID_Info is
         ID     : String := Get_Line (Input);
         BID    : Box_ID;
         Counts : Box_Symb_Count := (others => 0);
         Double,
         Triple : Boolean := False;
      begin
         for I in Box_ID'Range loop
            BID (I) := Box_ID_Symb (ID (I));
            Counts (BID (I)) := Counts (BID (I)) + 1;
         end loop;
         for S in Box_ID_Symb'Range loop
            if Counts (S) = 2 then
               Double := True;
            elsif Counts (S) = 3 then
               Triple := True;
            end if;
            exit when Double and Triple;
         end loop;
         return (Id     => BID, Counts => Counts,
                 Double => Double, Triple => Triple);
      end Get_Box;

      function Similar_IDs (Left, Right: Box_ID_Info;
                            Common     : out String) return Boolean is

         Diffs : Integer range 0 .. Box_ID'Last := 0;
         Diff  : Integer range Left.ID'Range;
         Cmn   : String(Left.ID'First .. Left.ID'Last - 1);

      begin

         for I in Box_ID'Range loop
            if Left.ID (I) /= Right.ID (I) then
               Diffs := Diffs + 1;
               Diff  := I;
            end if;
            exit when Diffs > 1;
         end loop;

         for I in Integer range Box_ID'First .. Diff-1 loop
            Cmn (I) := Character (Left.ID (I));
         end loop;
         for I in Integer range Diff+1 .. Box_ID'Last loop
            Cmn (I-1) := Character (Left.ID (I));
         end loop;
         Common := Cmn;
         return Diffs <= 1;

      end Similar_IDs;

   end Warehouse_Box; use Warehouse_Box;

   Input        : File_Type;
   Input_Length : Count := 0;

   -- Count the number box ids with symbols twice repeated and thrice repeated
   Double_Count : Integer := 0;
   Triple_Count : Integer := 0;
   -- String containing only the symbols which are the same in each position
   -- between the two target boxes
   Common       : String (Box_ID'First .. Box_ID'Last-1);

begin

   Open (File => Input,
         Mode => In_File,
         Name => "inputs/day2.txt");

   while not End_Of_File (Input) loop
      Input_Length := Input_Length + 1;
      Skip_Line (Input);
   end loop;
   Reset (Input);

   declare
      Boxes  : array (1..Input_Length) of Box_ID_Info;
      Found  : Boolean := False;
   begin
      for I in Boxes'Range loop
         Boxes (I) := Get_Box (Input);
         if Boxes (I).Double then Double_Count := Double_Count + 1; end if;
         if Boxes (I).Triple then Triple_Count := Triple_Count + 1; end if;
         for J in 1 .. I-1 loop
            exit when Found;
            if Similar_IDs (Boxes (I), Boxes (J), Common) then
               Found := True;
            end if;
         end loop;
      end loop;
   end;

   Close (Input);

   Checksum := Double_Count * Triple_Count;
   return Common;

end Day2;
