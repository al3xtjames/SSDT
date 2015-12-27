#define DISABLE_USBX		1
#define INTEL_GBE_DEVICE	\_SB.PCI0.GIGE

DefinitionBlock ("SSDT-GA-Z77X-UP5-TH.aml", "SSDT", 2, "APPLE ", "General", 0x20151227)
{
	External (_SB.PCI0, DeviceObj)

	External (_SB.PCI0.RP05, DeviceObj)
	External (_SB.PCI0.RP07, DeviceObj)

	External (_SB.PCI0.RP05.PXSX, DeviceObj)
	External (_SB.PCI0.RP07.PXSX, DeviceObj)

	#include "../include/chipset/Z77.asl"

	Scope (\_SB.PCI0)
	{
		Name (PW94, Package () { 0x09, 0x04 })

		Scope (RP05)
		{
			// Disabling the PXSX device
			Scope (PXSX) { Name (_STA, Zero) }
			// Adding a new XH02 device
			Device (XH02)
			{
				Name (_ADR, Zero)
				Alias (PW94, _PRW)
				Method (_DSM, 4)
				{
					If (Arg2 == Zero) { Return (Buffer() { 0x03 }) }
					Store (0x00, Index (\_SB.PCI0.EH01.PROP, 0x07))
					Return (\_SB.PCI0.EH01.PROP)
				}
			}
		}

		Scope (RP07)
		{
			// Disabling the PXSX device
			Scope (PXSX) { Name (_STA, Zero) }
			// Adding a new GIGE device
			Device (GIGE)
			{
				Name (_ADR, Zero)
				Alias (PW94, _PRW)
			}
		}
	}
}
