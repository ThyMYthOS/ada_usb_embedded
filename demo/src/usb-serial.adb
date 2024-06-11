--  with RP.ROM;

with Demo_Config; use Demo_Config;

package body USB.Serial is

   procedure Initialize is
      Status : Init_Result;
   begin
      if not USB_Stack.Register_Class (USB_Serial'Access) then
         raise Fatal_Error with "Failed to register USB Serial device class";
      end if;

      Status :=
        USB_Stack.Initialize
          (Controller      => UDC'Access,
           Manufacturer    => To_USB_String (USB_Manufacturer),
           Product         => To_USB_String (USB_Product),
           Serial_Number   => To_USB_String (USB_Serial_Number),
           Max_Packet_Size => Max_Ctrl_Packet_Size, Vendor_Id => USB_Vendor_Id,
           Product_Id      => USB_Product_Id, Bcd_Device => USB_Bcd_Device);

      if Status /= Ok then
         raise Fatal_Error
           with "USB stack initialization failed: " & Status'Image;
      end if;

      USB_Stack.Start;
   end Initialize;

   procedure Process is
      Buffer : String (1 .. Usb_Buffer_Size);
      Length : UInt32;
   begin
      USB_Stack.Poll;
      --  if USB_Serial.Line_Coding.Bitrate = 1_200 then
      --     RP.ROM.reset_to_usb_boot (0, 0);
      --  end if;
      if USB_Serial.List_Ctrl_State.DTE_Is_Present then
         USB_Serial.Read (Buffer, Length);
         USB_Stack.Poll;
         USB_Serial.Write (UDC, Buffer (1 .. Integer (Length)), Length);
      end if;
   end Process;
end USB.Serial;
