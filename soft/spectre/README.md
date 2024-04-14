## Spectre - Mac Emulation

Here is the patched version of spectre 2.6.5 and a bootable System 6.0.4 mac image.

The image is an ICD partition image with 1 partition. This will appear as an ACK type if you look at this in the ICDFMT program.

If you are using an ultrasatan, the image for the mac will need to be dd'ed to an SD card or if you are using an acsi2stm based unit, format the card as extfat.

Place the image named as hd0.img (that is a zero) in a folder called acsi2stm.

Run the spectre.prg program (Spectre 2.6.5). Make sure there are no ACC's loaded and you have at least 2MB RAM.

In the HD... Devices menu, select SCSI 0 or 1 whichever has the mac image on it (on the ultra Satan the first SD is SCSI 0 and the second is SCSI 1):
hd_image

Spectre should see the partition and image named.

Select Boot from HD and Auto Mount.

Note: This version of spectre will work on the ST running on the MiSTer, an ST, and an STE with TOS 1.0.4, 1.6.2 or 2.0.6.

It will NOT run under hatari due to the Mac performing a page zero write (which is 100% normal for the mac) but it kills hatari.

## Links
* https://forums.atariage.com/topic/300778-spectre-disks/page/5/
* [Atari ST Ultrasatan Spectre Mac](https://obsolescenceguaranteed.blogspot.com/2013/04/atari-st-ultrasatan-spectre-mac.html)
