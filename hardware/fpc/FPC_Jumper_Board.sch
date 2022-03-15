<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="2" name="Route2" color="1" fill="3" visible="no" active="no"/>
<layer number="3" name="Route3" color="4" fill="3" visible="no" active="no"/>
<layer number="4" name="Route4" color="1" fill="4" visible="no" active="no"/>
<layer number="5" name="Route5" color="4" fill="4" visible="no" active="no"/>
<layer number="6" name="Route6" color="1" fill="8" visible="no" active="no"/>
<layer number="7" name="Route7" color="4" fill="8" visible="no" active="no"/>
<layer number="8" name="Route8" color="1" fill="2" visible="no" active="no"/>
<layer number="9" name="Route9" color="4" fill="2" visible="no" active="no"/>
<layer number="10" name="Route10" color="1" fill="7" visible="no" active="no"/>
<layer number="11" name="Route11" color="4" fill="7" visible="no" active="no"/>
<layer number="12" name="Route12" color="1" fill="5" visible="no" active="no"/>
<layer number="13" name="Route13" color="4" fill="5" visible="no" active="no"/>
<layer number="14" name="Route14" color="1" fill="6" visible="no" active="no"/>
<layer number="15" name="Route15" color="4" fill="6" visible="no" active="no"/>
<layer number="16" name="Bottom" color="4" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="1" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="1" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="1" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="1" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="1" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="4" fill="1" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="0" fill="1" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="0" fill="1" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="Molex - 52746-1671">
<description>Upverter Parts Library

Created by Upverter.com</description>
<packages>
<package name="MOLEX_52746-1671_0">
<description>MOLX-52746-1671</description>
<polygon width="0" layer="1">
<vertex x="-7.4" y="0.424"/>
<vertex x="-5" y="0.424"/>
<vertex x="-5" y="-2.626"/>
<vertex x="-6.3" y="-2.626"/>
<vertex x="-6.3" y="-1.777"/>
<vertex x="-6.3" y="-1.776"/>
<vertex x="-7.4" y="-1.776"/>
</polygon>
<polygon width="0" layer="29">
<vertex x="-7.4" y="0.424"/>
<vertex x="-5" y="0.424"/>
<vertex x="-5" y="-2.626"/>
<vertex x="-6.3" y="-2.626"/>
<vertex x="-6.3" y="-1.777"/>
<vertex x="-6.3" y="-1.776"/>
<vertex x="-7.4" y="-1.776"/>
</polygon>
<polygon width="0" layer="31">
<vertex x="-7.4" y="0.424"/>
<vertex x="-5" y="0.424"/>
<vertex x="-5" y="-2.626"/>
<vertex x="-6.3" y="-2.626"/>
<vertex x="-6.3" y="-1.777"/>
<vertex x="-6.3" y="-1.776"/>
<vertex x="-7.4" y="-1.776"/>
</polygon>
<polygon width="0" layer="1">
<vertex x="5" y="0.424"/>
<vertex x="7.4" y="0.424"/>
<vertex x="7.4" y="-1.776"/>
<vertex x="7.4" y="-1.777"/>
<vertex x="6.3" y="-1.777"/>
<vertex x="6.3" y="-2.626"/>
<vertex x="5" y="-2.626"/>
</polygon>
<polygon width="0" layer="29">
<vertex x="5" y="0.424"/>
<vertex x="7.4" y="0.424"/>
<vertex x="7.4" y="-1.776"/>
<vertex x="7.4" y="-1.777"/>
<vertex x="6.3" y="-1.777"/>
<vertex x="6.3" y="-2.626"/>
<vertex x="5" y="-2.626"/>
</polygon>
<polygon width="0" layer="31">
<vertex x="5" y="0.424"/>
<vertex x="7.4" y="0.424"/>
<vertex x="7.4" y="-1.776"/>
<vertex x="7.4" y="-1.777"/>
<vertex x="6.3" y="-1.777"/>
<vertex x="6.3" y="-2.626"/>
<vertex x="5" y="-2.626"/>
</polygon>
<polygon width="0" layer="41">
<vertex x="-5" y="-0.176"/>
<vertex x="-4.2" y="-0.176"/>
<vertex x="-4.2" y="-1.516"/>
<vertex x="-5" y="-1.516"/>
</polygon>
<polygon width="0" layer="41">
<vertex x="5" y="-0.176"/>
<vertex x="4.2" y="-0.176"/>
<vertex x="4.2" y="-1.516"/>
<vertex x="5" y="-1.516"/>
</polygon>
<wire x1="6.15" y1="-3.226" x2="6.15" y2="0.224" width="0.1" layer="51"/>
<wire x1="-6.15" y1="-3.226" x2="-6.15" y2="0.224" width="0.1" layer="51"/>
<wire x1="-6.15" y1="-3.226" x2="-5.4" y2="-3.226" width="0.1" layer="51"/>
<wire x1="-5.525" y1="-4.876" x2="-5.525" y2="-3.226" width="0.1" layer="51"/>
<wire x1="-7.05" y1="-4.876" x2="-5.4" y2="-4.876" width="0.1" layer="51"/>
<wire x1="-7.05" y1="-5.676" x2="-7.05" y2="-4.877" width="0.1" layer="51"/>
<wire x1="-7.05" y1="-5.677" x2="7.05" y2="-5.677" width="0.1" layer="51"/>
<wire x1="7.05" y1="-5.677" x2="7.05" y2="-4.876" width="0.1" layer="51"/>
<wire x1="5.4" y1="-4.876" x2="7.05" y2="-4.876" width="0.1" layer="51"/>
<wire x1="5.525" y1="-4.876" x2="5.525" y2="-3.226" width="0.1" layer="51"/>
<wire x1="5.4" y1="-3.226" x2="6.15" y2="-3.226" width="0.1" layer="51"/>
<wire x1="-6.15" y1="0.224" x2="6.15" y2="0.224" width="0.1" layer="51"/>
<wire x1="-5.4" y1="-4.876" x2="5.4" y2="-4.876" width="0.1" layer="51"/>
<wire x1="-5.4" y1="-3.226" x2="5.4" y2="-3.226" width="0.1" layer="51"/>
<wire x1="-6.15" y1="-3.226" x2="-6.15" y2="-3.026" width="0.15" layer="21"/>
<wire x1="-6.15" y1="-3.226" x2="-5.525" y2="-3.226" width="0.15" layer="21"/>
<wire x1="-5.525" y1="-4.876" x2="-5.525" y2="-3.239" width="0.15" layer="21"/>
<wire x1="-7.05" y1="-4.877" x2="-5.525" y2="-4.877" width="0.15" layer="21"/>
<wire x1="-7.05" y1="-5.676" x2="-7.05" y2="-4.877" width="0.15" layer="21"/>
<wire x1="-7.05" y1="-5.676" x2="7.05" y2="-5.676" width="0.15" layer="21"/>
<wire x1="7.05" y1="-5.676" x2="7.05" y2="-4.876" width="0.15" layer="21"/>
<wire x1="5.525" y1="-4.876" x2="7.05" y2="-4.876" width="0.15" layer="21"/>
<wire x1="5.525" y1="-4.876" x2="5.525" y2="-3.226" width="0.15" layer="21"/>
<wire x1="5.525" y1="-3.226" x2="6.15" y2="-3.226" width="0.15" layer="21"/>
<wire x1="6.15" y1="-3.226" x2="6.15" y2="-3.026" width="0.15" layer="21"/>
<wire x1="-7.5" y1="-5.777" x2="-7.5" y2="1.324" width="0.1" layer="39"/>
<wire x1="-7.5" y1="1.324" x2="7.5" y2="1.324" width="0.1" layer="39"/>
<wire x1="7.5" y1="1.324" x2="7.5" y2="-5.777" width="0.1" layer="39"/>
<wire x1="7.5" y1="-5.777" x2="-7.5" y2="-5.777" width="0.1" layer="39"/>
<text x="-8.5" y="1.899" size="1" layer="25">&gt;NAME</text>
<circle x="-3.75" y="1.774" radius="0.125" width="0.25" layer="21"/>
<smd name="10" x="0.75" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="7" x="-0.75" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="11" x="1.25" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="6" x="-1.25" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="12" x="1.75" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="5" x="-1.75" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="4" x="-2.25" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="9" x="0.25" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="14" x="2.75" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="3" x="-2.75" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="15" x="3.25" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="2" x="-3.25" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="1" x="-3.75" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="8" x="-0.25" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="13" x="2.25" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="16" x="3.75" y="0.824" dx="0.3" dy="0.8" layer="1"/>
<smd name="MP2" x="6.134" y="-0.824" dx="1" dy="1" layer="1"/>
<smd name="MP1" x="-6.134" y="-0.824" dx="1" dy="1" layer="1" rot="R180"/>
</package>
</packages>
<symbols>
<symbol name="MOLEX_52746-1671_0_0">
<description>MOLX-52746-1671</description>
<wire x1="0" y1="-10.16" x2="0" y2="-5.08" width="0.254" layer="94"/>
<wire x1="0" y1="-5.08" x2="50.8" y2="-5.08" width="0.254" layer="94"/>
<wire x1="50.8" y1="-5.08" x2="50.8" y2="-10.16" width="0.254" layer="94"/>
<wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94"/>
<wire x1="10.16" y1="-10.16" x2="10.16" y2="-8.382" width="0.254" layer="94"/>
<wire x1="7.62" y1="-10.16" x2="7.62" y2="-8.382" width="0.254" layer="94"/>
<wire x1="5.08" y1="-10.16" x2="5.08" y2="-8.382" width="0.254" layer="94"/>
<wire x1="2.54" y1="-10.16" x2="2.54" y2="-8.382" width="0.254" layer="94"/>
<wire x1="15.24" y1="-10.16" x2="15.24" y2="-8.382" width="0.254" layer="94"/>
<wire x1="12.7" y1="-10.16" x2="12.7" y2="-8.382" width="0.254" layer="94"/>
<wire x1="20.32" y1="-10.16" x2="20.32" y2="-8.382" width="0.254" layer="94"/>
<wire x1="17.78" y1="-10.16" x2="17.78" y2="-8.382" width="0.254" layer="94"/>
<wire x1="25.4" y1="-10.16" x2="25.4" y2="-8.382" width="0.254" layer="94"/>
<wire x1="22.86" y1="-10.16" x2="22.86" y2="-8.382" width="0.254" layer="94"/>
<wire x1="27.94" y1="-10.16" x2="27.94" y2="-8.382" width="0.254" layer="94"/>
<wire x1="30.48" y1="-10.16" x2="30.48" y2="-8.382" width="0.254" layer="94"/>
<wire x1="33.02" y1="-10.16" x2="33.02" y2="-8.382" width="0.254" layer="94"/>
<wire x1="35.56" y1="-10.16" x2="35.56" y2="-8.382" width="0.254" layer="94"/>
<wire x1="38.1" y1="-10.16" x2="38.1" y2="-8.382" width="0.254" layer="94"/>
<wire x1="40.64" y1="-10.16" x2="40.64" y2="-8.382" width="0.254" layer="94"/>
<wire x1="2.54" y1="-10.16" x2="2.54" y2="-10.16" width="0.15" layer="94"/>
<wire x1="5.08" y1="-10.16" x2="5.08" y2="-10.16" width="0.15" layer="94"/>
<wire x1="7.62" y1="-10.16" x2="7.62" y2="-10.16" width="0.15" layer="94"/>
<wire x1="10.16" y1="-10.16" x2="10.16" y2="-10.16" width="0.15" layer="94"/>
<wire x1="45.72" y1="-10.16" x2="45.72" y2="-10.16" width="0.15" layer="94"/>
<wire x1="48.26" y1="-10.16" x2="48.26" y2="-10.16" width="0.15" layer="94"/>
<wire x1="12.7" y1="-10.16" x2="12.7" y2="-10.16" width="0.15" layer="94"/>
<wire x1="15.24" y1="-10.16" x2="15.24" y2="-10.16" width="0.15" layer="94"/>
<wire x1="17.78" y1="-10.16" x2="17.78" y2="-10.16" width="0.15" layer="94"/>
<wire x1="20.32" y1="-10.16" x2="20.32" y2="-10.16" width="0.15" layer="94"/>
<wire x1="22.86" y1="-10.16" x2="22.86" y2="-10.16" width="0.15" layer="94"/>
<wire x1="25.4" y1="-10.16" x2="25.4" y2="-10.16" width="0.15" layer="94"/>
<wire x1="27.94" y1="-10.16" x2="27.94" y2="-10.16" width="0.15" layer="94"/>
<wire x1="30.48" y1="-10.16" x2="30.48" y2="-10.16" width="0.15" layer="94"/>
<wire x1="33.02" y1="-10.16" x2="33.02" y2="-10.16" width="0.15" layer="94"/>
<wire x1="35.56" y1="-10.16" x2="35.56" y2="-10.16" width="0.15" layer="94"/>
<wire x1="38.1" y1="-10.16" x2="38.1" y2="-10.16" width="0.15" layer="94"/>
<wire x1="40.64" y1="-10.16" x2="40.64" y2="-10.16" width="0.15" layer="94"/>
<text x="0" y="-2.54" size="2.54" layer="95" align="top-left">&gt;NAME</text>
<text x="0" y="-15.24" size="2.54" layer="95" align="top-left">52746-1671</text>
<pin name="1" x="2.54" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="2" x="5.08" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="3" x="7.62" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="4" x="10.16" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="MP1" x="45.72" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="MP2" x="48.26" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="5" x="12.7" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="6" x="15.24" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="7" x="17.78" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="8" x="20.32" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="9" x="22.86" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="10" x="25.4" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="11" x="27.94" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="12" x="30.48" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="13" x="33.02" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="14" x="35.56" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="15" x="38.1" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<pin name="16" x="40.64" y="-15.24" visible="pad" length="middle" direction="pas" rot="R90"/>
<circle x="10.16" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="7.62" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="5.08" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="2.54" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="15.24" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="12.7" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="20.32" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="17.78" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="25.4" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="22.86" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="27.94" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="30.48" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="33.02" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="35.56" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="38.1" y="-7.62" radius="0.762" width="0.254" layer="94"/>
<circle x="40.64" y="-7.62" radius="0.762" width="0.254" layer="94"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="MOLEX_52746-1671" prefix="J">
<description>MOLX-52746-1671</description>
<gates>
<gate name="G$0" symbol="MOLEX_52746-1671_0_0" x="0" y="0"/>
</gates>
<devices>
<device name="MOLEX_52746-1671_0_0" package="MOLEX_52746-1671_0">
<connects>
<connect gate="G$0" pin="1" pad="1"/>
<connect gate="G$0" pin="10" pad="10"/>
<connect gate="G$0" pin="11" pad="11"/>
<connect gate="G$0" pin="12" pad="12"/>
<connect gate="G$0" pin="13" pad="13"/>
<connect gate="G$0" pin="14" pad="14"/>
<connect gate="G$0" pin="15" pad="15"/>
<connect gate="G$0" pin="16" pad="16"/>
<connect gate="G$0" pin="2" pad="2"/>
<connect gate="G$0" pin="3" pad="3"/>
<connect gate="G$0" pin="4" pad="4"/>
<connect gate="G$0" pin="5" pad="5"/>
<connect gate="G$0" pin="6" pad="6"/>
<connect gate="G$0" pin="7" pad="7"/>
<connect gate="G$0" pin="8" pad="8"/>
<connect gate="G$0" pin="9" pad="9"/>
<connect gate="G$0" pin="MP1" pad="MP1"/>
<connect gate="G$0" pin="MP2" pad="MP2"/>
</connects>
<technologies>
<technology name="">
<attribute name="CIIVA_IDS" value="1134637"/>
<attribute name="CIRCUITS_LOADED" value="16"/>
<attribute name="COMPONENT_LINK_1_DESCRIPTION" value="Manufacturer URL"/>
<attribute name="COMPONENT_LINK_1_URL" value="http://www.molex.com/molex/index.jsp"/>
<attribute name="COMPONENT_LINK_3_DESCRIPTION" value="Package Specification"/>
<attribute name="COMPONENT_LINK_3_URL" value="http://www.molex.com/pdm_docs/sd/527461671_sd.pdf"/>
<attribute name="CONTACT_POSITION" value="Bottom"/>
<attribute name="CURRENT_MAX_PER_CONTACT" value="0.5A"/>
<attribute name="DATASHEET" value="http://www.molex.com/webdocs/datasheets/pdf/en-us/0527461671_FFC_FPC_CONNECTORS.pdf"/>
<attribute name="DURABILITY_MATING_CYCLES_MAX" value="20"/>
<attribute name="ENTRY_ANGLE" value="90degrees Angle"/>
<attribute name="FOOTPRINT_VARIANT_NAME_0" value="Manufacturer Recommended"/>
<attribute name="IMPORTED" value="yes"/>
<attribute name="IMPORTED_FROM" value="vault"/>
<attribute name="IMPORT_TS" value="1521847824"/>
<attribute name="MATED_HEIGHT" value="2.00mm"/>
<attribute name="MATERIAL___METAL" value="Phosphor Bronze"/>
<attribute name="MATERIAL___PLATING_MATING" value="Gold"/>
<attribute name="MATERIAL___PLATING_TERMINATION" value="Gold"/>
<attribute name="MF" value="Molex"/>
<attribute name="MOUNTING_TECHNOLOGY" value="Surface Mount"/>
<attribute name="MPN" value="52746-1671"/>
<attribute name="NUMBER_OF_ROWS" value="1"/>
<attribute name="ORIENTATION" value="Right Angle"/>
<attribute name="PACKAGE" value="52746-1671"/>
<attribute name="PACKAGE_DESCRIPTION" value="16-Lead FPC Connector, Pitch 0.5 mm"/>
<attribute name="PACKAGE_VERSION" value="Rev. H, 05/2009"/>
<attribute name="PACKING" value="Tape and Reel"/>
<attribute name="PCB_LOCATOR" value="No"/>
<attribute name="PCB_RETENTION" value="Yes"/>
<attribute name="PITCH___MATING_INTERFACE" value="0.50mm"/>
<attribute name="POLARIZED_TO_PCB" value="Yes"/>
<attribute name="PREFIX" value="J"/>
<attribute name="RELEASE_DATE" value="1411386965"/>
<attribute name="ROHS" value="Yes"/>
<attribute name="STACKABLE" value="No"/>
<attribute name="VAULT_GUID" value="42AFEF3A-7427-4485-B9DD-4384D0932A2E"/>
<attribute name="VAULT_REVISION" value="AA2C4A7A-D62C-479B-A4C7-3B738B5CC8F1"/>
<attribute name="VOLTAGE_MAX" value="50V"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="pinhead" urn="urn:adsk.eagle:library:325">
<description>&lt;b&gt;Pin Header Connectors&lt;/b&gt;&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="1X16" urn="urn:adsk.eagle:footprint:22297/1" library_version="4">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="15.24" y1="0.635" x2="15.875" y2="1.27" width="0.1524" layer="21"/>
<wire x1="15.875" y1="1.27" x2="17.145" y2="1.27" width="0.1524" layer="21"/>
<wire x1="17.145" y1="1.27" x2="17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="17.78" y1="0.635" x2="17.78" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="17.78" y1="-0.635" x2="17.145" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="17.145" y1="-1.27" x2="15.875" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="15.875" y1="-1.27" x2="15.24" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="10.795" y1="1.27" x2="12.065" y2="1.27" width="0.1524" layer="21"/>
<wire x1="12.065" y1="1.27" x2="12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="12.7" y1="0.635" x2="12.7" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="12.7" y1="-0.635" x2="12.065" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="12.7" y1="0.635" x2="13.335" y2="1.27" width="0.1524" layer="21"/>
<wire x1="13.335" y1="1.27" x2="14.605" y2="1.27" width="0.1524" layer="21"/>
<wire x1="14.605" y1="1.27" x2="15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="15.24" y1="0.635" x2="15.24" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-0.635" x2="14.605" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="14.605" y1="-1.27" x2="13.335" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="13.335" y1="-1.27" x2="12.7" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="0.635" x2="8.255" y2="1.27" width="0.1524" layer="21"/>
<wire x1="8.255" y1="1.27" x2="9.525" y2="1.27" width="0.1524" layer="21"/>
<wire x1="9.525" y1="1.27" x2="10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="10.16" y1="0.635" x2="10.16" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-0.635" x2="9.525" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="9.525" y1="-1.27" x2="8.255" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="8.255" y1="-1.27" x2="7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="10.795" y1="1.27" x2="10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-0.635" x2="10.795" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="12.065" y1="-1.27" x2="10.795" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="3.175" y1="1.27" x2="4.445" y2="1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="1.27" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0.635" x2="5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-0.635" x2="4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0.635" x2="5.715" y2="1.27" width="0.1524" layer="21"/>
<wire x1="5.715" y1="1.27" x2="6.985" y2="1.27" width="0.1524" layer="21"/>
<wire x1="6.985" y1="1.27" x2="7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="0.635" x2="7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="-0.635" x2="6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="6.985" y1="-1.27" x2="5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="5.715" y1="-1.27" x2="5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="1.27" x2="1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="1.27" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-0.635" x2="1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="1.905" y1="-1.27" x2="0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="0.635" y1="-1.27" x2="0" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="3.175" y1="1.27" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-0.635" x2="3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="4.445" y1="-1.27" x2="3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="1.27" x2="-3.175" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="1.27" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-0.635" x2="-3.175" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-1.905" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="1.27" x2="-0.635" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="1.27" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="0" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="-0.635" x2="-0.635" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-0.635" y1="-1.27" x2="-1.905" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-1.905" y1="-1.27" x2="-2.54" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0.635" x2="-6.985" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="1.27" x2="-5.715" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="1.27" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0.635" x2="-5.08" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-0.635" x2="-5.715" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-5.715" y1="-1.27" x2="-6.985" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-6.985" y1="-1.27" x2="-7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-4.445" y1="1.27" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-0.635" x2="-4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-3.175" y1="-1.27" x2="-4.445" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-12.065" y1="1.27" x2="-10.795" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-10.795" y1="1.27" x2="-10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="0.635" x2="-10.16" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-0.635" x2="-10.795" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="0.635" x2="-9.525" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-9.525" y1="1.27" x2="-8.255" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="1.27" x2="-7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0.635" x2="-7.62" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="-0.635" x2="-8.255" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-8.255" y1="-1.27" x2="-9.525" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-9.525" y1="-1.27" x2="-10.16" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="0.635" x2="-14.605" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-14.605" y1="1.27" x2="-13.335" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="1.27" x2="-12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="0.635" x2="-12.7" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="-0.635" x2="-13.335" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-13.335" y1="-1.27" x2="-14.605" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-14.605" y1="-1.27" x2="-15.24" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-12.065" y1="1.27" x2="-12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="-0.635" x2="-12.065" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-10.795" y1="-1.27" x2="-12.065" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-19.685" y1="1.27" x2="-18.415" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-18.415" y1="1.27" x2="-17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="0.635" x2="-17.78" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="-0.635" x2="-18.415" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="0.635" x2="-17.145" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-17.145" y1="1.27" x2="-15.875" y2="1.27" width="0.1524" layer="21"/>
<wire x1="-15.875" y1="1.27" x2="-15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="0.635" x2="-15.24" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="-0.635" x2="-15.875" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-15.875" y1="-1.27" x2="-17.145" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-17.145" y1="-1.27" x2="-17.78" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-20.32" y1="0.635" x2="-20.32" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="-19.685" y1="1.27" x2="-20.32" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-20.32" y1="-0.635" x2="-19.685" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="-18.415" y1="-1.27" x2="-19.685" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="17.78" y1="0.635" x2="18.415" y2="1.27" width="0.1524" layer="21"/>
<wire x1="18.415" y1="1.27" x2="19.685" y2="1.27" width="0.1524" layer="21"/>
<wire x1="19.685" y1="1.27" x2="20.32" y2="0.635" width="0.1524" layer="21"/>
<wire x1="20.32" y1="0.635" x2="20.32" y2="-0.635" width="0.1524" layer="21"/>
<wire x1="20.32" y1="-0.635" x2="19.685" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="19.685" y1="-1.27" x2="18.415" y2="-1.27" width="0.1524" layer="21"/>
<wire x1="18.415" y1="-1.27" x2="17.78" y2="-0.635" width="0.1524" layer="21"/>
<pad name="1" x="-19.05" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="2" x="-16.51" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="3" x="-13.97" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="4" x="-11.43" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="5" x="-8.89" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="6" x="-6.35" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="7" x="-3.81" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="8" x="-1.27" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="9" x="1.27" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="10" x="3.81" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="11" x="6.35" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="12" x="8.89" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="13" x="11.43" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="14" x="13.97" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="15" x="16.51" y="0" drill="1.016" shape="long" rot="R90"/>
<pad name="16" x="19.05" y="0" drill="1.016" shape="long" rot="R90"/>
<text x="-20.3962" y="1.8288" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-20.32" y="-3.175" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="16.256" y1="-0.254" x2="16.764" y2="0.254" layer="51"/>
<rectangle x1="13.716" y1="-0.254" x2="14.224" y2="0.254" layer="51"/>
<rectangle x1="11.176" y1="-0.254" x2="11.684" y2="0.254" layer="51"/>
<rectangle x1="8.636" y1="-0.254" x2="9.144" y2="0.254" layer="51"/>
<rectangle x1="6.096" y1="-0.254" x2="6.604" y2="0.254" layer="51"/>
<rectangle x1="3.556" y1="-0.254" x2="4.064" y2="0.254" layer="51"/>
<rectangle x1="1.016" y1="-0.254" x2="1.524" y2="0.254" layer="51"/>
<rectangle x1="-1.524" y1="-0.254" x2="-1.016" y2="0.254" layer="51"/>
<rectangle x1="-4.064" y1="-0.254" x2="-3.556" y2="0.254" layer="51"/>
<rectangle x1="-6.604" y1="-0.254" x2="-6.096" y2="0.254" layer="51"/>
<rectangle x1="-9.144" y1="-0.254" x2="-8.636" y2="0.254" layer="51"/>
<rectangle x1="-11.684" y1="-0.254" x2="-11.176" y2="0.254" layer="51"/>
<rectangle x1="-14.224" y1="-0.254" x2="-13.716" y2="0.254" layer="51"/>
<rectangle x1="-16.764" y1="-0.254" x2="-16.256" y2="0.254" layer="51"/>
<rectangle x1="-19.304" y1="-0.254" x2="-18.796" y2="0.254" layer="51"/>
<rectangle x1="18.796" y1="-0.254" x2="19.304" y2="0.254" layer="51"/>
</package>
<package name="1X16/90" urn="urn:adsk.eagle:footprint:22298/1" library_version="4">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<wire x1="-20.32" y1="-1.905" x2="-17.78" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="-1.905" x2="-17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-17.78" y1="0.635" x2="-20.32" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-20.32" y1="0.635" x2="-20.32" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-19.05" y1="6.985" x2="-19.05" y2="1.27" width="0.762" layer="21"/>
<wire x1="-17.78" y1="-1.905" x2="-15.24" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="-1.905" x2="-15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-15.24" y1="0.635" x2="-17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-16.51" y1="6.985" x2="-16.51" y2="1.27" width="0.762" layer="21"/>
<wire x1="-15.24" y1="-1.905" x2="-12.7" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="-1.905" x2="-12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-12.7" y1="0.635" x2="-15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-13.97" y1="6.985" x2="-13.97" y2="1.27" width="0.762" layer="21"/>
<wire x1="-12.7" y1="-1.905" x2="-10.16" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-1.905" x2="-10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="0.635" x2="-12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-11.43" y1="6.985" x2="-11.43" y2="1.27" width="0.762" layer="21"/>
<wire x1="-10.16" y1="-1.905" x2="-7.62" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="-1.905" x2="-7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-7.62" y1="0.635" x2="-10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-8.89" y1="6.985" x2="-8.89" y2="1.27" width="0.762" layer="21"/>
<wire x1="-7.62" y1="-1.905" x2="-5.08" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="-1.905" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-5.08" y1="0.635" x2="-7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-6.35" y1="6.985" x2="-6.35" y2="1.27" width="0.762" layer="21"/>
<wire x1="-5.08" y1="-1.905" x2="-2.54" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="-1.905" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-2.54" y1="0.635" x2="-5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-3.81" y1="6.985" x2="-3.81" y2="1.27" width="0.762" layer="21"/>
<wire x1="-2.54" y1="-1.905" x2="0" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="0" y1="-1.905" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="0" y1="0.635" x2="-2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="-1.27" y1="6.985" x2="-1.27" y2="1.27" width="0.762" layer="21"/>
<wire x1="0" y1="-1.905" x2="2.54" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="2.54" y1="-1.905" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="2.54" y1="0.635" x2="0" y2="0.635" width="0.1524" layer="21"/>
<wire x1="1.27" y1="6.985" x2="1.27" y2="1.27" width="0.762" layer="21"/>
<wire x1="2.54" y1="-1.905" x2="5.08" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="5.08" y1="-1.905" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="5.08" y1="0.635" x2="2.54" y2="0.635" width="0.1524" layer="21"/>
<wire x1="3.81" y1="6.985" x2="3.81" y2="1.27" width="0.762" layer="21"/>
<wire x1="5.08" y1="-1.905" x2="7.62" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="7.62" y1="-1.905" x2="7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="7.62" y1="0.635" x2="5.08" y2="0.635" width="0.1524" layer="21"/>
<wire x1="6.35" y1="6.985" x2="6.35" y2="1.27" width="0.762" layer="21"/>
<wire x1="7.62" y1="-1.905" x2="10.16" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="10.16" y1="-1.905" x2="10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="10.16" y1="0.635" x2="7.62" y2="0.635" width="0.1524" layer="21"/>
<wire x1="8.89" y1="6.985" x2="8.89" y2="1.27" width="0.762" layer="21"/>
<wire x1="10.16" y1="-1.905" x2="12.7" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="12.7" y1="-1.905" x2="12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="12.7" y1="0.635" x2="10.16" y2="0.635" width="0.1524" layer="21"/>
<wire x1="11.43" y1="6.985" x2="11.43" y2="1.27" width="0.762" layer="21"/>
<wire x1="12.7" y1="-1.905" x2="15.24" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="15.24" y1="-1.905" x2="15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="15.24" y1="0.635" x2="12.7" y2="0.635" width="0.1524" layer="21"/>
<wire x1="13.97" y1="6.985" x2="13.97" y2="1.27" width="0.762" layer="21"/>
<wire x1="15.24" y1="-1.905" x2="17.78" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="17.78" y1="-1.905" x2="17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="17.78" y1="0.635" x2="15.24" y2="0.635" width="0.1524" layer="21"/>
<wire x1="16.51" y1="6.985" x2="16.51" y2="1.27" width="0.762" layer="21"/>
<wire x1="17.78" y1="-1.905" x2="20.32" y2="-1.905" width="0.1524" layer="21"/>
<wire x1="20.32" y1="-1.905" x2="20.32" y2="0.635" width="0.1524" layer="21"/>
<wire x1="20.32" y1="0.635" x2="17.78" y2="0.635" width="0.1524" layer="21"/>
<wire x1="19.05" y1="6.985" x2="19.05" y2="1.27" width="0.762" layer="21"/>
<pad name="1" x="-19.05" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="2" x="-16.51" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="3" x="-13.97" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="4" x="-11.43" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="5" x="-8.89" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="6" x="-6.35" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="7" x="-3.81" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="8" x="-1.27" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="9" x="1.27" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="10" x="3.81" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="11" x="6.35" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="12" x="8.89" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="13" x="11.43" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="14" x="13.97" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="15" x="16.51" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<pad name="16" x="19.05" y="-3.81" drill="1.016" shape="long" rot="R90"/>
<text x="-20.955" y="-3.81" size="1.27" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<text x="22.225" y="-3.81" size="1.27" layer="27" rot="R90">&gt;VALUE</text>
<rectangle x1="-19.431" y1="0.635" x2="-18.669" y2="1.143" layer="21"/>
<rectangle x1="-16.891" y1="0.635" x2="-16.129" y2="1.143" layer="21"/>
<rectangle x1="-14.351" y1="0.635" x2="-13.589" y2="1.143" layer="21"/>
<rectangle x1="-11.811" y1="0.635" x2="-11.049" y2="1.143" layer="21"/>
<rectangle x1="-9.271" y1="0.635" x2="-8.509" y2="1.143" layer="21"/>
<rectangle x1="-6.731" y1="0.635" x2="-5.969" y2="1.143" layer="21"/>
<rectangle x1="-4.191" y1="0.635" x2="-3.429" y2="1.143" layer="21"/>
<rectangle x1="-1.651" y1="0.635" x2="-0.889" y2="1.143" layer="21"/>
<rectangle x1="0.889" y1="0.635" x2="1.651" y2="1.143" layer="21"/>
<rectangle x1="3.429" y1="0.635" x2="4.191" y2="1.143" layer="21"/>
<rectangle x1="5.969" y1="0.635" x2="6.731" y2="1.143" layer="21"/>
<rectangle x1="8.509" y1="0.635" x2="9.271" y2="1.143" layer="21"/>
<rectangle x1="11.049" y1="0.635" x2="11.811" y2="1.143" layer="21"/>
<rectangle x1="13.589" y1="0.635" x2="14.351" y2="1.143" layer="21"/>
<rectangle x1="16.129" y1="0.635" x2="16.891" y2="1.143" layer="21"/>
<rectangle x1="18.669" y1="0.635" x2="19.431" y2="1.143" layer="21"/>
<rectangle x1="-19.431" y1="-2.921" x2="-18.669" y2="-1.905" layer="21"/>
<rectangle x1="-16.891" y1="-2.921" x2="-16.129" y2="-1.905" layer="21"/>
<rectangle x1="-14.351" y1="-2.921" x2="-13.589" y2="-1.905" layer="21"/>
<rectangle x1="-11.811" y1="-2.921" x2="-11.049" y2="-1.905" layer="21"/>
<rectangle x1="-9.271" y1="-2.921" x2="-8.509" y2="-1.905" layer="21"/>
<rectangle x1="-6.731" y1="-2.921" x2="-5.969" y2="-1.905" layer="21"/>
<rectangle x1="-4.191" y1="-2.921" x2="-3.429" y2="-1.905" layer="21"/>
<rectangle x1="-1.651" y1="-2.921" x2="-0.889" y2="-1.905" layer="21"/>
<rectangle x1="0.889" y1="-2.921" x2="1.651" y2="-1.905" layer="21"/>
<rectangle x1="3.429" y1="-2.921" x2="4.191" y2="-1.905" layer="21"/>
<rectangle x1="5.969" y1="-2.921" x2="6.731" y2="-1.905" layer="21"/>
<rectangle x1="8.509" y1="-2.921" x2="9.271" y2="-1.905" layer="21"/>
<rectangle x1="11.049" y1="-2.921" x2="11.811" y2="-1.905" layer="21"/>
<rectangle x1="13.589" y1="-2.921" x2="14.351" y2="-1.905" layer="21"/>
<rectangle x1="16.129" y1="-2.921" x2="16.891" y2="-1.905" layer="21"/>
<rectangle x1="18.669" y1="-2.921" x2="19.431" y2="-1.905" layer="21"/>
</package>
</packages>
<packages3d>
<package3d name="1X16" urn="urn:adsk.eagle:package:22432/2" type="model" library_version="4">
<description>PIN HEADER</description>
<packageinstances>
<packageinstance name="1X16"/>
</packageinstances>
</package3d>
<package3d name="1X16/90" urn="urn:adsk.eagle:package:22430/2" type="model" library_version="4">
<description>PIN HEADER</description>
<packageinstances>
<packageinstance name="1X16/90"/>
</packageinstances>
</package3d>
</packages3d>
<symbols>
<symbol name="PINHD16" urn="urn:adsk.eagle:symbol:22296/1" library_version="4">
<wire x1="-6.35" y1="-22.86" x2="1.27" y2="-22.86" width="0.4064" layer="94"/>
<wire x1="1.27" y1="-22.86" x2="1.27" y2="20.32" width="0.4064" layer="94"/>
<wire x1="1.27" y1="20.32" x2="-6.35" y2="20.32" width="0.4064" layer="94"/>
<wire x1="-6.35" y1="20.32" x2="-6.35" y2="-22.86" width="0.4064" layer="94"/>
<text x="-6.35" y="20.955" size="1.778" layer="95">&gt;NAME</text>
<text x="-6.35" y="-25.4" size="1.778" layer="96">&gt;VALUE</text>
<pin name="1" x="-2.54" y="17.78" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="2" x="-2.54" y="15.24" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="3" x="-2.54" y="12.7" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="4" x="-2.54" y="10.16" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="5" x="-2.54" y="7.62" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="6" x="-2.54" y="5.08" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="7" x="-2.54" y="2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="8" x="-2.54" y="0" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="9" x="-2.54" y="-2.54" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="10" x="-2.54" y="-5.08" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="11" x="-2.54" y="-7.62" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="12" x="-2.54" y="-10.16" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="13" x="-2.54" y="-12.7" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="14" x="-2.54" y="-15.24" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="15" x="-2.54" y="-17.78" visible="pad" length="short" direction="pas" function="dot"/>
<pin name="16" x="-2.54" y="-20.32" visible="pad" length="short" direction="pas" function="dot"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="PINHD-1X16" urn="urn:adsk.eagle:component:22522/4" prefix="JP" uservalue="yes" library_version="4">
<description>&lt;b&gt;PIN HEADER&lt;/b&gt;</description>
<gates>
<gate name="A" symbol="PINHD16" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1X16">
<connects>
<connect gate="A" pin="1" pad="1"/>
<connect gate="A" pin="10" pad="10"/>
<connect gate="A" pin="11" pad="11"/>
<connect gate="A" pin="12" pad="12"/>
<connect gate="A" pin="13" pad="13"/>
<connect gate="A" pin="14" pad="14"/>
<connect gate="A" pin="15" pad="15"/>
<connect gate="A" pin="16" pad="16"/>
<connect gate="A" pin="2" pad="2"/>
<connect gate="A" pin="3" pad="3"/>
<connect gate="A" pin="4" pad="4"/>
<connect gate="A" pin="5" pad="5"/>
<connect gate="A" pin="6" pad="6"/>
<connect gate="A" pin="7" pad="7"/>
<connect gate="A" pin="8" pad="8"/>
<connect gate="A" pin="9" pad="9"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:22432/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="17" constant="no"/>
</technology>
</technologies>
</device>
<device name="/90" package="1X16/90">
<connects>
<connect gate="A" pin="1" pad="1"/>
<connect gate="A" pin="10" pad="10"/>
<connect gate="A" pin="11" pad="11"/>
<connect gate="A" pin="12" pad="12"/>
<connect gate="A" pin="13" pad="13"/>
<connect gate="A" pin="14" pad="14"/>
<connect gate="A" pin="15" pad="15"/>
<connect gate="A" pin="16" pad="16"/>
<connect gate="A" pin="2" pad="2"/>
<connect gate="A" pin="3" pad="3"/>
<connect gate="A" pin="4" pad="4"/>
<connect gate="A" pin="5" pad="5"/>
<connect gate="A" pin="6" pad="6"/>
<connect gate="A" pin="7" pad="7"/>
<connect gate="A" pin="8" pad="8"/>
<connect gate="A" pin="9" pad="9"/>
</connects>
<package3dinstances>
<package3dinstance package3d_urn="urn:adsk.eagle:package:22430/2"/>
</package3dinstances>
<technologies>
<technology name="">
<attribute name="POPULARITY" value="0" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="J1" library="Molex - 52746-1671" deviceset="MOLEX_52746-1671" device="MOLEX_52746-1671_0_0"/>
<part name="J2" library="Molex - 52746-1671" deviceset="MOLEX_52746-1671" device="MOLEX_52746-1671_0_0"/>
<part name="JP1" library="pinhead" library_urn="urn:adsk.eagle:library:325" deviceset="PINHD-1X16" device="" package3d_urn="urn:adsk.eagle:package:22432/2"/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="J1" gate="G$0" x="38.1" y="76.2" smashed="yes">
<attribute name="NAME" x="38.1" y="73.66" size="2.54" layer="95" align="top-left"/>
</instance>
<instance part="J2" gate="G$0" x="81.28" y="35.56" smashed="yes" rot="R180">
<attribute name="NAME" x="81.28" y="38.1" size="2.54" layer="95" rot="R180" align="top-left"/>
</instance>
<instance part="JP1" gate="A" x="60.96" y="27.94" smashed="yes" rot="R270">
<attribute name="NAME" x="81.915" y="34.29" size="1.778" layer="95" rot="R270"/>
<attribute name="VALUE" x="35.56" y="34.29" size="1.778" layer="96" rot="R270"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="1" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="1"/>
<wire x1="40.64" y1="60.96" x2="40.64" y2="50.8" width="0.1524" layer="91"/>
<label x="40.64" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="16"/>
<pinref part="JP1" gate="A" pin="16"/>
<wire x1="40.64" y1="30.48" x2="40.64" y2="50.8" width="0.1524" layer="91"/>
<junction x="40.64" y="50.8"/>
</segment>
</net>
<net name="2" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="2"/>
<wire x1="43.18" y1="60.96" x2="43.18" y2="50.8" width="0.1524" layer="91"/>
<label x="43.18" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="15"/>
<pinref part="JP1" gate="A" pin="15"/>
<wire x1="43.18" y1="30.48" x2="43.18" y2="50.8" width="0.1524" layer="91"/>
<junction x="43.18" y="50.8"/>
</segment>
</net>
<net name="3" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="3"/>
<wire x1="45.72" y1="60.96" x2="45.72" y2="50.8" width="0.1524" layer="91"/>
<label x="45.72" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="14"/>
<pinref part="JP1" gate="A" pin="14"/>
<wire x1="45.72" y1="30.48" x2="45.72" y2="50.8" width="0.1524" layer="91"/>
<junction x="45.72" y="50.8"/>
</segment>
</net>
<net name="4" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="4"/>
<wire x1="48.26" y1="60.96" x2="48.26" y2="50.8" width="0.1524" layer="91"/>
<label x="48.26" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="13"/>
<pinref part="JP1" gate="A" pin="13"/>
<wire x1="48.26" y1="30.48" x2="48.26" y2="50.8" width="0.1524" layer="91"/>
<junction x="48.26" y="50.8"/>
</segment>
</net>
<net name="MP1" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="MP1"/>
<wire x1="83.82" y1="60.96" x2="83.82" y2="50.8" width="0.1524" layer="91"/>
<label x="83.82" y="53.34" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="MP2" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="MP2"/>
<wire x1="86.36" y1="60.96" x2="86.36" y2="50.8" width="0.1524" layer="91"/>
<label x="86.36" y="53.34" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="5" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="5"/>
<wire x1="50.8" y1="60.96" x2="50.8" y2="50.8" width="0.1524" layer="91"/>
<label x="50.8" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="12"/>
<pinref part="JP1" gate="A" pin="12"/>
<wire x1="50.8" y1="30.48" x2="50.8" y2="50.8" width="0.1524" layer="91"/>
<junction x="50.8" y="50.8"/>
</segment>
</net>
<net name="6" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="6"/>
<wire x1="53.34" y1="60.96" x2="53.34" y2="50.8" width="0.1524" layer="91"/>
<label x="53.34" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="11"/>
<pinref part="JP1" gate="A" pin="11"/>
<wire x1="53.34" y1="30.48" x2="53.34" y2="50.8" width="0.1524" layer="91"/>
<junction x="53.34" y="50.8"/>
</segment>
</net>
<net name="7" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="7"/>
<wire x1="55.88" y1="60.96" x2="55.88" y2="50.8" width="0.1524" layer="91"/>
<label x="55.88" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="10"/>
<pinref part="JP1" gate="A" pin="10"/>
<wire x1="55.88" y1="30.48" x2="55.88" y2="50.8" width="0.1524" layer="91"/>
<junction x="55.88" y="50.8"/>
</segment>
</net>
<net name="8" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="8"/>
<wire x1="58.42" y1="60.96" x2="58.42" y2="50.8" width="0.1524" layer="91"/>
<label x="58.42" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="9"/>
<pinref part="JP1" gate="A" pin="9"/>
<wire x1="58.42" y1="30.48" x2="58.42" y2="50.8" width="0.1524" layer="91"/>
<junction x="58.42" y="50.8"/>
</segment>
</net>
<net name="9" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="9"/>
<wire x1="60.96" y1="60.96" x2="60.96" y2="50.8" width="0.1524" layer="91"/>
<label x="60.96" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="8"/>
<pinref part="JP1" gate="A" pin="8"/>
<wire x1="60.96" y1="30.48" x2="60.96" y2="50.8" width="0.1524" layer="91"/>
<junction x="60.96" y="50.8"/>
</segment>
</net>
<net name="10" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="10"/>
<wire x1="63.5" y1="60.96" x2="63.5" y2="50.8" width="0.1524" layer="91"/>
<label x="63.5" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="7"/>
<pinref part="JP1" gate="A" pin="7"/>
<wire x1="63.5" y1="30.48" x2="63.5" y2="50.8" width="0.1524" layer="91"/>
<junction x="63.5" y="50.8"/>
</segment>
</net>
<net name="11" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="11"/>
<wire x1="66.04" y1="60.96" x2="66.04" y2="50.8" width="0.1524" layer="91"/>
<label x="66.04" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="6"/>
<pinref part="JP1" gate="A" pin="6"/>
<wire x1="66.04" y1="30.48" x2="66.04" y2="50.8" width="0.1524" layer="91"/>
<junction x="66.04" y="50.8"/>
</segment>
</net>
<net name="12" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="12"/>
<wire x1="68.58" y1="60.96" x2="68.58" y2="50.8" width="0.1524" layer="91"/>
<label x="68.58" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="5"/>
<pinref part="JP1" gate="A" pin="5"/>
<wire x1="68.58" y1="30.48" x2="68.58" y2="50.8" width="0.1524" layer="91"/>
<junction x="68.58" y="50.8"/>
</segment>
</net>
<net name="13" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="13"/>
<wire x1="71.12" y1="60.96" x2="71.12" y2="50.8" width="0.1524" layer="91"/>
<label x="71.12" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="4"/>
<pinref part="JP1" gate="A" pin="4"/>
<wire x1="71.12" y1="30.48" x2="71.12" y2="50.8" width="0.1524" layer="91"/>
<junction x="71.12" y="50.8"/>
</segment>
</net>
<net name="14" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="14"/>
<wire x1="73.66" y1="60.96" x2="73.66" y2="50.8" width="0.1524" layer="91"/>
<label x="73.66" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="3"/>
<pinref part="JP1" gate="A" pin="3"/>
<wire x1="73.66" y1="30.48" x2="73.66" y2="50.8" width="0.1524" layer="91"/>
<junction x="73.66" y="50.8"/>
</segment>
</net>
<net name="15" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="15"/>
<wire x1="76.2" y1="60.96" x2="76.2" y2="50.8" width="0.1524" layer="91"/>
<label x="76.2" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="2"/>
<pinref part="JP1" gate="A" pin="2"/>
<wire x1="76.2" y1="30.48" x2="76.2" y2="50.8" width="0.1524" layer="91"/>
<junction x="76.2" y="50.8"/>
</segment>
</net>
<net name="16" class="0">
<segment>
<pinref part="J1" gate="G$0" pin="16"/>
<wire x1="78.74" y1="60.96" x2="78.74" y2="50.8" width="0.1524" layer="91"/>
<label x="78.74" y="53.34" size="1.778" layer="95" rot="R90"/>
<pinref part="J2" gate="G$0" pin="1"/>
<pinref part="JP1" gate="A" pin="1"/>
<wire x1="78.74" y1="50.8" x2="78.74" y2="30.48" width="0.1524" layer="91"/>
<junction x="78.74" y="50.8"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="8.2" severity="warning">
Since Version 8.2, EAGLE supports online libraries. The ids
of those online libraries will not be understood (or retained)
with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports URNs for individual library
assets (packages, symbols, and devices). The URNs of those assets
will not be understood (or retained) with this version.
</note>
<note version="8.3" severity="warning">
Since Version 8.3, EAGLE supports the association of 3D packages
with devices in libraries, schematics, and board files. Those 3D
packages will not be understood (or retained) with this version.
</note>
</compatibility>
</eagle>
