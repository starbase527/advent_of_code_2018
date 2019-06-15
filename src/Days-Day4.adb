
with Ada.Calendar;
with Ada.Calendar.Formatting;
with Ada.Containers.Hashed_Maps;

separate (Days)

procedure Day4 (Guard_Asleep_Longest : out GuardID;
                Minute_Most_Asleep   : out Ada.Calendar.Formatting.Minute_Number) is

   type Watch_Event is (Begins_Shift, Falls_Asleep, Wakes_Up);

   type Watch_Entry (Event : Watch_Event) is record
      Month  : Ada.Calendar.Month_Number;
      Day    : Ada.Calendar.Day_Number;
      Hour   : Ada.Calendar.Formatting.Hour_Number;
      Minute : Ada.Calendar.Formatting.Minute_Number;
      case Event is
         when Begins_Shift => Guard : GuardID;
         when others => null;
      end case;
   end record;

   function Parse_Watch_Record (Raw_Record : String) return Watch_Entry is
      Raw_Time : String (1 .. 19);
      Time     : Ada.Calendar.Time;
      Month    : Ada.Calendar.Month_Number;
      Day      : Ada.Calendar.Day_Number;
      Hour     : Ada.Calendar.Formatting.Hour_Number;
      Minute   : Ada.Calendar.Formatting.Minute_Number;
      GID      : GuardID;
      Event    : Watch_Event;
   begin
      pragma Warnings (Off, "index for ""Raw_Record"" may assume lower bound of 1");
      Raw_Time (1 .. 16)  := Raw_Record (2 .. 17);
      Raw_Time (1 .. 4)   := "2018"; -- Necessary as Ada.Calendar.Time doesn't work with such old dates
      Raw_Time (17 .. 19) := ":00";
      Time := Ada.Calendar.Formatting.Value (Raw_Time);
      Month  := Ada.Calendar.Formatting.Month (Time);
      Day    := Ada.Calendar.Formatting.Day (Time);
      Hour   := Ada.Calendar.Formatting.Hour (Time);
      Minute := Ada.Calendar.Formatting.Minute (Time);

      if Raw_Record (20 .. 24) = "Guard" then
         declare
            Exited : Boolean := False;
         begin
            for I in 27 .. Raw_Record'Last loop
               if Raw_Record (I) = ' ' then
                  GID := GuardID'Value (Raw_Record (27 .. I-1));
                  Exited := True;
                  exit;
               end if;
            end loop;
            if not Exited then
               raise Data_Error;
            end if;
         end;
         Event := Begins_Shift;
      elsif Raw_Record (20 .. 24) = "falls" then
         Event := Falls_Asleep;
      elsif Raw_Record (20 .. 24) = "wakes" then
         Event := Wakes_Up;
      else
         raise Data_Error;
      end if;
      pragma Warnings (On, "index for ""Raw_Record"" may assume lower bound of 1");

      case Event is
         when Begins_Shift =>
            return (Event  => Begins_Shift,
                    Month  => Month,
                    Day    => Day,
                    Hour   => Hour,
                    Minute => Minute,
                    Guard  => GID);
         when Falls_Asleep =>
            return (Event  => Falls_Asleep,
                    Month  => Month,
                    Day    => Day,
                    Hour   => Hour,
                    Minute => Minute);
         when Wakes_Up =>
            return (Event  => Wakes_Up,
                    Month  => Month,
                    Day    => Day,
                    Hour   => Hour,
                    Minute => Minute);
      end case;
   end Parse_Watch_Record;

   Input : File_Type;

begin

   Open(File => Input,
        Mode => In_File,
        Name => "inputs/day4.txt");

   while not End_Of_File (Input) loop
      declare
         This_Entry : Watch_Entry := Parse_Watch_Record (Get_Line (Input));
      begin
         Put_Line (This_Entry.Event'Image);
      end;
   end loop;

   Close (Input);

   Guard_Asleep_Longest := 5;
   Minute_Most_Asleep := 27;

end Day4;
