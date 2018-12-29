
separate (Days)

function Day3 (Safe_Claim : out Positive) return Fabric_Extent is

   type Cloth_Dimension is range 0 .. 1000;

   type Cloth_Section is record
      ID         : Positive;
      Left       : Cloth_Dimension;
      Top        : Cloth_Dimension;
      Width      : Cloth_Dimension;
      Height     : Cloth_Dimension;
   end record;

   procedure Print_CLoth_Section (CS : Cloth_Section) is
   begin
      Put_Line ("ID: " & CS.ID'Image);
      Put_Line (" L: " & CS.Left'Image);
      Put_Line (" T: " & CS.Top'Image);
      Put_Line (" W: " & CS.Width'Image);
      Put_Line (" H: " & CS.Height'Image);
   end;


   function Parse_Input (Line : String) return Cloth_Section is
      ID         : Positive;
      L, T, W, H : Cloth_Dimension;
      subtype Index is Integer range Line'Range;
      Break      : Index := Index'Invalid_Value;
   begin
      for I in Line'Range loop
         if Line (I) = '@' then
            ID := Integer'Value (Line (Line'First + 1 .. I-2));
            Break := I;
         end if;
         if Line (I) = ',' then
            L  := Cloth_Dimension'Value (Line (Break+2 .. I-1));
            Break := I;
         end if;
         if Line (I) = ':' then
            T  := Cloth_Dimension'Value (Line (Break+1 .. I-1));
            Break := I;
         end if;
         if Line (I) = 'x' then
            W  := Cloth_Dimension'Value (Line (Break+2 .. I-1));
            Break := I;
         end if;
      end loop;
      H := Cloth_Dimension'Value (Line (Break+1 .. Line'Last));

      return (ID => ID, Left => L, Top => T, Width => W, Height => H);
   end Parse_Input;

   Input        : File_Type;
   Input_Length : Natural := 0;
   Overlap      : Fabric_Extent := 0;


begin

   Open(File => Input,
        Mode => In_File,
        Name => "inputs/day3.txt");

   while not End_Of_File (Input) loop
      Skip_Line (Input);
      Input_Length := Input_Length + 1;
   end loop;
   Reset (Input);

   declare
      type Cloth_Claims is range 0 .. Cloth_Dimension'Last*Cloth_Dimension'Last;
      Cloth : array (Cloth_Dimension, Cloth_Dimension) of Cloth_Claims
        := (others => (others => 0));
   begin
      while not End_Of_File (Input) loop
         declare
            Line : String := Get_Line (Input);
            This_Section : Cloth_Section := Parse_Input (Line);
         begin
            for I in 1 .. This_Section.Width loop
               for J in 1 .. This_Section.Height loop
                  Cloth (I + This_Section.Left, J + This_Section.Top)
                    := Cloth (I + This_Section.Left, J + This_Section.Top) + 1;
               end loop;
            end loop;
         end;
      end loop;

      for J in Cloth_Dimension'Range loop
         for I in Cloth_Dimension'Range loop
--              Put (Cloth (I, J)'Image);
            if Cloth (I, J) > 1 then Overlap := Overlap + 1; end if;
         end loop;
--           New_Line;
      end loop;

      Reset (Input);
      all_claims:
      while not End_Of_File (Input) loop
         declare
            Line : String := Get_Line (Input);
            This_Section : Cloth_Section := Parse_Input (Line);
            This_Claim_Safe : Boolean := True;
         begin
            check_claim:
            for I in 1 .. This_Section.Width loop
               for J in 1 .. This_Section.Height loop
                  if Cloth (I + This_Section.Left, J + This_Section.Top) > 1 then
                     This_Claim_Safe := False;
                     exit check_claim;
                  end if;
               end loop;
            end loop check_claim;

            if This_Claim_Safe then
               Safe_Claim := This_Section.ID;
               exit all_claims;
            end if;
         end;
      end loop all_claims;
   end;

   Close (Input);

   return Overlap;

end Day3;
