with RP.USB_Device;
with USB.Device.Serial;
with USB.Device; use USB.Device;

package USB.Serial is
   Fatal_Error : exception;

   Max_Ctrl_Packet_Size : constant := 64;
   Usb_Buffer_Size      : constant := 2048;

   UDC : aliased RP.USB_Device.USB_Device_Controller;
   USB_Stack  : USB_Device_Stack (Max_Classes => 1);
   USB_Serial :
     aliased USB.Device.Serial.Default_Serial_Class
       (TX_Buffer_Size => Usb_Buffer_Size, RX_Buffer_Size => Usb_Buffer_Size);

   procedure Initialize;
   procedure Process;
end USB.Serial;
