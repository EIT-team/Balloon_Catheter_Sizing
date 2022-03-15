<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="yes" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="2" name="Route2" color="16" fill="1" visible="no" active="no"/>
<layer number="3" name="Route3" color="17" fill="1" visible="no" active="no"/>
<layer number="4" name="Route4" color="18" fill="1" visible="no" active="no"/>
<layer number="5" name="Route5" color="19" fill="1" visible="no" active="no"/>
<layer number="6" name="Route6" color="25" fill="1" visible="no" active="no"/>
<layer number="7" name="Route7" color="26" fill="1" visible="no" active="no"/>
<layer number="8" name="Route8" color="27" fill="1" visible="no" active="no"/>
<layer number="9" name="Route9" color="28" fill="1" visible="no" active="no"/>
<layer number="10" name="Route10" color="29" fill="1" visible="no" active="no"/>
<layer number="11" name="Route11" color="30" fill="1" visible="no" active="no"/>
<layer number="12" name="Route12" color="20" fill="1" visible="no" active="no"/>
<layer number="13" name="Route13" color="21" fill="1" visible="no" active="no"/>
<layer number="14" name="Route14" color="22" fill="1" visible="no" active="no"/>
<layer number="15" name="Route15" color="23" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="24" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
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
<layer number="97" name="Info" color="7" fill="1" visible="no" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="RigidPCBSensor_1">
<description>Generated from &lt;b&gt;RigidPCBSensor_1.sch&lt;/b&gt;&lt;p&gt;
by exp-lbrs.ulp</description>
<packages>
<package name="B1,27">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<wire x1="-0.635" y1="0" x2="0.635" y2="0" width="0.0024" layer="37"/>
<wire x1="0" y1="0.635" x2="0" y2="-0.635" width="0.0024" layer="37"/>
<smd name="TP" x="0" y="0" dx="1.27" dy="1.27" layer="1" roundness="100" cream="no"/>
<text x="-0.635" y="1.016" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-0.635" y="-0.762" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-0.635" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="B2,54">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<circle x="0" y="0" radius="0.635" width="0.254" layer="37"/>
<wire x1="-0.635" y1="0" x2="0.635" y2="0" width="0.0024" layer="37"/>
<wire x1="0" y1="-0.635" x2="0" y2="0.635" width="0.0024" layer="37"/>
<smd name="TP" x="0" y="0" dx="2.54" dy="2.54" layer="1" roundness="100" cream="no"/>
<text x="-1.27" y="1.651" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="-1.27" y="-1.397" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-1.27" y="-3.175" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="P1-13">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<circle x="0" y="0" radius="0.762" width="0.1524" layer="51"/>
<rectangle x1="-0.3302" y1="-0.3302" x2="0.3302" y2="0.3302" layer="51"/>
<pad name="TP" x="0" y="0" drill="1.3208" diameter="2.159" shape="octagon"/>
<text x="-1.016" y="1.27" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0" y="0" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-1.27" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="P1-13Y">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<circle x="0" y="0" radius="0.762" width="0.1524" layer="51"/>
<rectangle x1="-0.3302" y1="-0.3302" x2="0.3302" y2="0.3302" layer="51"/>
<pad name="TP" x="0" y="0" drill="1.3208" diameter="1.905" shape="long" rot="R90"/>
<text x="-0.889" y="2.159" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0" y="0" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-1.27" y="-3.81" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="P1-17">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<circle x="0" y="0" radius="0.8128" width="0.1524" layer="51"/>
<rectangle x1="-0.3302" y1="-0.3302" x2="0.3302" y2="0.3302" layer="51"/>
<pad name="TP" x="0" y="0" drill="1.7018" diameter="2.54" shape="octagon"/>
<text x="-1.143" y="1.397" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0" y="0" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-1.27" y="-3.175" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="P1-17Y">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<circle x="0" y="0" radius="0.8128" width="0.1524" layer="51"/>
<rectangle x1="-0.3302" y1="-0.3302" x2="0.3302" y2="0.3302" layer="51"/>
<pad name="TP" x="0" y="0" drill="1.7018" diameter="2.1208" shape="long" rot="R90"/>
<text x="-1.143" y="2.286" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0" y="0" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-1.27" y="-3.81" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="P1-20">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<circle x="0" y="0" radius="1.016" width="0.1524" layer="51"/>
<rectangle x1="-0.3302" y1="-0.3302" x2="0.3302" y2="0.3302" layer="51"/>
<pad name="TP" x="0" y="0" drill="2.0066" diameter="3.1496" shape="octagon"/>
<text x="-1.524" y="1.778" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0" y="0" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-1.27" y="-3.175" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="P1-20Y">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<circle x="0" y="0" radius="1.016" width="0.1524" layer="51"/>
<rectangle x1="-0.3302" y1="-0.3302" x2="0.3302" y2="0.3302" layer="51"/>
<pad name="TP" x="0" y="0" drill="2.0066" diameter="2.54" shape="long" rot="R90"/>
<text x="-1.27" y="2.794" size="1.27" layer="25" ratio="10">&gt;NAME</text>
<text x="0" y="0" size="0.0254" layer="27">&gt;VALUE</text>
<text x="-1.27" y="-4.445" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP06R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="0.6" dy="0.6" layer="1" roundness="100" cream="no"/>
<text x="-0.3" y="0.4001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.254" y="-0.381" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP06SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="0.5996" dy="0.5996" layer="1" cream="no"/>
<text x="-0.3" y="0.4001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.254" y="-0.381" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP07R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="0.7" dy="0.7" layer="1" roundness="100" cream="no"/>
<text x="-0.3" y="0.4001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.254" y="-0.508" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP07SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="0.7" dy="0.7" layer="1" cream="no"/>
<text x="-0.3" y="0.4001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.381" y="-0.381" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP08R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="0.8" dy="0.8" layer="1" roundness="100" cream="no"/>
<text x="-0.3" y="0.4001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.381" y="-0.381" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP08SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="0.8" dy="0.8" layer="1" cream="no"/>
<text x="-0.3" y="0.4001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.381" y="-0.508" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP09R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="0.9" dy="0.9" layer="1" roundness="100" cream="no"/>
<text x="-0.4501" y="0.5001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.381" y="-0.508" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP09SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="0.8998" dy="0.8998" layer="1" cream="no"/>
<text x="-0.4501" y="0.5001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.381" y="-0.508" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP10R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1" dy="1" layer="1" roundness="100" cream="no"/>
<text x="-0.5001" y="0.5499" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.381" y="-0.508" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP10SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1" dy="1" layer="1" cream="no"/>
<text x="-0.5001" y="0.5499" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.635" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP11R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.1" dy="1.1" layer="1" roundness="100" cream="no"/>
<text x="-0.5499" y="0.5999" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.508" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP11SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.1" dy="1.1" layer="1" cream="no"/>
<text x="-0.5499" y="0.5999" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.635" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP12R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.2" dy="1.2" layer="1" roundness="100" cream="no"/>
<text x="-0.5999" y="0.65" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.635" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP12SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.1998" dy="1.1998" layer="1" cream="no"/>
<text x="-0.5999" y="0.65" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.635" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP13R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.3" dy="1.3" layer="1" roundness="100" cream="no"/>
<text x="-0.65" y="0.7" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.635" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP13SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.3" dy="1.3" layer="1" cream="no"/>
<text x="-0.65" y="0.7" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-0.762" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP14R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.4" dy="1.4" layer="1" roundness="100" cream="no"/>
<text x="-0.7" y="0.7501" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.762" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP14SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.4" dy="1.4" layer="1" cream="no"/>
<text x="-0.7" y="0.7501" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-0.762" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP15R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.5" dy="1.5" layer="1" roundness="100" cream="no"/>
<text x="-0.7501" y="0.8001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-0.762" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP15SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.5" dy="1.5" layer="1" cream="no"/>
<text x="-0.7501" y="0.8001" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.762" y="-0.889" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP16R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.6" dy="1.6" layer="1" roundness="100" cream="no"/>
<text x="-0.8001" y="0.8499" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-0.762" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP16SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.5996" dy="1.5996" layer="1" cream="no"/>
<text x="-0.8001" y="0.8499" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.762" y="-0.889" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP17R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.7" dy="1.7" layer="1" roundness="100" cream="no"/>
<text x="-0.8499" y="0.8999" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.635" y="-0.889" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP17SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.7" dy="1.7" layer="1" cream="no"/>
<text x="-0.8499" y="0.8999" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.762" y="-0.889" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP18R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.8" dy="1.8" layer="1" roundness="100" cream="no"/>
<text x="-0.8999" y="0.95" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.762" y="-0.889" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP18SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.8" dy="1.8" layer="1" cream="no"/>
<text x="-0.8999" y="0.95" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.889" y="-1.016" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP19R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.9" dy="1.9" layer="1" roundness="100" cream="no"/>
<text x="-0.95" y="1" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.762" y="-0.889" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP19SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="1.8998" dy="1.8998" layer="1" cream="no"/>
<text x="-0.95" y="1" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.889" y="-1.016" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP20R">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="2" dy="2" layer="1" roundness="100" cream="no"/>
<text x="-1" y="1.05" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.762" y="-1.016" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP20SQ">
<description>&lt;b&gt;TEST PAD&lt;/b&gt;</description>
<smd name="TP" x="0" y="0" dx="2" dy="2" layer="1" cream="no"/>
<text x="-1" y="1.05" size="1.27" layer="25">&gt;NAME</text>
<text x="-1.016" y="-1.143" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-2.54" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="TP10SQLONG">
<smd name="TP" x="0" y="0" dx="1.016" dy="2.032" layer="1" cream="no"/>
<text x="-0.5001" y="0.5499" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.635" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
</package>
<package name="ELECPAD">
<smd name="TP" x="0" y="0" dx="1.1" dy="2.1" layer="1" stop="no" thermals="no" cream="no"/>
<text x="-0.5001" y="0.5499" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.635" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
<rectangle x1="-0.5" y1="-1" x2="0.5" y2="1" layer="29"/>
</package>
<package name="ZIFPAD">
<smd name="TP" x="0" y="0" dx="0.3" dy="4" layer="1" stop="no" thermals="no" cream="no"/>
<text x="-0.5001" y="0.5499" size="1.27" layer="25">&gt;NAME</text>
<text x="-0.508" y="-0.635" size="0.0254" layer="27">&gt;VALUE</text>
<text x="0" y="-1.905" size="1" layer="37">&gt;TP_SIGNAL_NAME</text>
<rectangle x1="-0.25" y1="-2.1" x2="0.25" y2="2" layer="29"/>
</package>
</packages>
<symbols>
<symbol name="PS">
<rectangle x1="-0.381" y1="-5.207" x2="0.381" y2="-4.572" layer="94"/>
<wire x1="0.635" y1="-4.572" x2="-0.635" y2="-4.572" width="0.1524" layer="94"/>
<wire x1="0.635" y1="-4.572" x2="0.635" y2="0" width="0.1524" layer="94"/>
<wire x1="0.635" y1="0" x2="-0.635" y2="0" width="0.1524" layer="94"/>
<wire x1="-0.635" y1="0" x2="-0.635" y2="-4.572" width="0.1524" layer="94"/>
<wire x1="0.381" y1="-3.048" x2="-0.381" y2="-2.794" width="0.1524" layer="94"/>
<wire x1="-0.381" y1="-2.794" x2="0.381" y2="-2.54" width="0.1524" layer="94"/>
<wire x1="0.381" y1="-2.54" x2="-0.381" y2="-2.286" width="0.1524" layer="94"/>
<wire x1="-0.381" y1="-2.286" x2="0.381" y2="-2.032" width="0.1524" layer="94"/>
<wire x1="0.381" y1="-2.032" x2="-0.381" y2="-1.778" width="0.1524" layer="94"/>
<wire x1="-0.381" y1="-1.778" x2="0.381" y2="-1.524" width="0.1524" layer="94"/>
<wire x1="0.381" y1="-1.524" x2="-0.381" y2="-1.27" width="0.1524" layer="94"/>
<wire x1="-0.381" y1="-1.27" x2="0.381" y2="-1.016" width="0.1524" layer="94"/>
<wire x1="0.381" y1="-1.016" x2="-0.381" y2="-0.762" width="0.1524" layer="94"/>
<wire x1="-0.381" y1="-0.762" x2="0.381" y2="-0.508" width="0.1524" layer="94"/>
<wire x1="0.508" y1="-5.207" x2="-0.508" y2="-5.207" width="0.1524" layer="94"/>
<wire x1="-0.508" y1="-5.207" x2="-0.508" y2="-5.715" width="0.1524" layer="94"/>
<wire x1="-0.508" y1="-5.715" x2="0" y2="-6.35" width="0.1524" layer="94"/>
<wire x1="0" y1="-6.35" x2="0.508" y2="-5.715" width="0.1524" layer="94"/>
<wire x1="0.508" y1="-5.715" x2="0.508" y2="-5.207" width="0.1524" layer="94"/>
<pin name="TP" x="0" y="2.54" visible="off" length="short" direction="in" rot="R270"/>
<text x="-1.016" y="-6.35" size="1.778" layer="95" rot="R90">&gt;NAME</text>
<text x="1.27" y="-2.54" size="1.778" layer="97">&gt;TP_SIGNAL_NAME</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="PTR1" prefix="TP">
<description>&lt;b&gt;TEST PIN&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="PS" x="0" y="0"/>
</gates>
<devices>
<device name="B1,27" package="B1,27">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="B2,54" package="B2,54">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="PAD1-13" package="P1-13">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="PAD1-13Y" package="P1-13Y">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="PAD1-17" package="P1-17">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="PAD1-17Y" package="P1-17Y">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="PAD1-20" package="P1-20">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="PAD1-20Y" package="P1-20Y">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP06R" package="TP06R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP06SQ" package="TP06SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP07R" package="TP07R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP07SQ" package="TP07SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP08R" package="TP08R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP08SQ" package="TP08SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP09R" package="TP09R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP09SQ" package="TP09SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP10R" package="TP10R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP10SQ" package="TP10SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP11R" package="TP11R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP11SQ" package="TP11SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP12R" package="TP12R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP12SQ" package="TP12SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP13R" package="TP13R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP13SQ" package="TP13SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP14R" package="TP14R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP14SQ" package="TP14SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP15R" package="TP15R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP15SQ" package="TP15SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP16R" package="TP16R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP16SQ" package="TP16SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP17R" package="TP17R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP17SQ" package="TP17SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP18R" package="TP18R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP18SQ" package="TP18SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP19R" package="TP19R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP19SQ" package="TP19SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP20R" package="TP20R">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="TP20SQ" package="TP20SQ">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name="">
<attribute name="TP_SIGNAL_NAME" value="" constant="no"/>
</technology>
</technologies>
</device>
<device name="" package="TP10SQLONG">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="1X2MM" package="ELECPAD">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
<device name="ZIF" package="ZIFPAD">
<connects>
<connect gate="G$1" pin="TP" pad="TP"/>
</connects>
<technologies>
<technology name=""/>
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
<part name="1" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="5" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="12" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="16" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="2" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="6" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="11" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="15" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="3" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="7" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="10" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="14" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="4" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="8" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="9" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="13" library="RigidPCBSensor_1" deviceset="PTR1" device="1X2MM" value="PTR11X2MM"/>
<part name="TP17" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP18" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP19" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP20" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP21" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP22" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP23" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP24" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP25" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP26" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP27" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP28" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP29" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP30" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP31" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
<part name="TP32" library="RigidPCBSensor_1" deviceset="PTR1" device="ZIF" value="PTR1ZIF"/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="1" gate="G$1" x="35.56" y="83.82" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="82.804" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="5" gate="G$1" x="35.56" y="78.74" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="77.724" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="12" gate="G$1" x="35.56" y="73.66" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="72.644" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="16" gate="G$1" x="35.56" y="68.58" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="67.564" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="2" gate="G$1" x="35.56" y="63.5" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="62.484" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="6" gate="G$1" x="35.56" y="58.42" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="57.404" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="11" gate="G$1" x="35.56" y="53.34" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="52.324" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="15" gate="G$1" x="35.56" y="48.26" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="47.244" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="3" gate="G$1" x="35.56" y="43.18" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="42.164" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="7" gate="G$1" x="35.56" y="38.1" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="37.084" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="10" gate="G$1" x="35.56" y="33.02" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="32.004" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="14" gate="G$1" x="35.56" y="27.94" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="26.924" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="4" gate="G$1" x="35.56" y="22.86" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="21.844" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="8" gate="G$1" x="35.56" y="17.78" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="16.764" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="9" gate="G$1" x="35.56" y="12.7" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="11.684" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="13" gate="G$1" x="35.56" y="7.62" smashed="yes" rot="R90">
<attribute name="NAME" x="41.91" y="6.604" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP17" gate="G$1" x="55.88" y="83.82" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="82.804" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP18" gate="G$1" x="55.88" y="78.74" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="77.724" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP19" gate="G$1" x="55.88" y="73.66" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="72.644" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP20" gate="G$1" x="55.88" y="68.58" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="67.564" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP21" gate="G$1" x="55.88" y="63.5" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="62.484" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP22" gate="G$1" x="55.88" y="58.42" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="57.404" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP23" gate="G$1" x="55.88" y="53.34" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="52.324" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP24" gate="G$1" x="55.88" y="48.26" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="47.244" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP25" gate="G$1" x="55.88" y="43.18" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="42.164" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP26" gate="G$1" x="55.88" y="38.1" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="37.084" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP27" gate="G$1" x="55.88" y="33.02" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="32.004" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP28" gate="G$1" x="55.88" y="27.94" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="26.924" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP29" gate="G$1" x="55.88" y="22.86" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="21.844" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP30" gate="G$1" x="55.88" y="17.78" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="16.764" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP31" gate="G$1" x="55.88" y="12.7" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="11.684" size="1.778" layer="95" rot="R180"/>
</instance>
<instance part="TP32" gate="G$1" x="55.88" y="7.62" smashed="yes" rot="R90">
<attribute name="NAME" x="62.23" y="6.604" size="1.778" layer="95" rot="R180"/>
</instance>
</instances>
<busses>
</busses>
<nets>
<net name="1" class="0">
<segment>
<pinref part="1" gate="G$1" pin="TP"/>
<pinref part="TP17" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="83.82" x2="53.34" y2="83.82" width="0.1524" layer="91"/>
</segment>
</net>
<net name="5" class="0">
<segment>
<pinref part="5" gate="G$1" pin="TP"/>
<pinref part="TP18" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="78.74" x2="53.34" y2="78.74" width="0.1524" layer="91"/>
</segment>
</net>
<net name="12" class="0">
<segment>
<pinref part="12" gate="G$1" pin="TP"/>
<pinref part="TP19" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="73.66" x2="53.34" y2="73.66" width="0.1524" layer="91"/>
</segment>
</net>
<net name="16" class="0">
<segment>
<pinref part="16" gate="G$1" pin="TP"/>
<pinref part="TP20" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="68.58" x2="53.34" y2="68.58" width="0.1524" layer="91"/>
</segment>
</net>
<net name="2" class="0">
<segment>
<pinref part="2" gate="G$1" pin="TP"/>
<pinref part="TP21" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="63.5" x2="53.34" y2="63.5" width="0.1524" layer="91"/>
</segment>
</net>
<net name="6" class="0">
<segment>
<pinref part="6" gate="G$1" pin="TP"/>
<pinref part="TP22" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="58.42" x2="53.34" y2="58.42" width="0.1524" layer="91"/>
</segment>
</net>
<net name="11" class="0">
<segment>
<pinref part="11" gate="G$1" pin="TP"/>
<pinref part="TP23" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="53.34" x2="53.34" y2="53.34" width="0.1524" layer="91"/>
</segment>
</net>
<net name="15" class="0">
<segment>
<pinref part="15" gate="G$1" pin="TP"/>
<pinref part="TP24" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="48.26" x2="53.34" y2="48.26" width="0.1524" layer="91"/>
</segment>
</net>
<net name="3" class="0">
<segment>
<pinref part="3" gate="G$1" pin="TP"/>
<pinref part="TP25" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="43.18" x2="53.34" y2="43.18" width="0.1524" layer="91"/>
</segment>
</net>
<net name="7" class="0">
<segment>
<pinref part="7" gate="G$1" pin="TP"/>
<pinref part="TP26" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="38.1" x2="53.34" y2="38.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="10" class="0">
<segment>
<pinref part="10" gate="G$1" pin="TP"/>
<pinref part="TP27" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="33.02" x2="53.34" y2="33.02" width="0.1524" layer="91"/>
</segment>
</net>
<net name="14" class="0">
<segment>
<pinref part="14" gate="G$1" pin="TP"/>
<pinref part="TP28" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="27.94" x2="53.34" y2="27.94" width="0.1524" layer="91"/>
</segment>
</net>
<net name="4" class="0">
<segment>
<pinref part="4" gate="G$1" pin="TP"/>
<pinref part="TP29" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="22.86" x2="53.34" y2="22.86" width="0.1524" layer="91"/>
</segment>
</net>
<net name="8" class="0">
<segment>
<pinref part="8" gate="G$1" pin="TP"/>
<pinref part="TP30" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="17.78" x2="53.34" y2="17.78" width="0.1524" layer="91"/>
</segment>
</net>
<net name="9" class="0">
<segment>
<pinref part="9" gate="G$1" pin="TP"/>
<pinref part="TP31" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="12.7" x2="53.34" y2="12.7" width="0.1524" layer="91"/>
</segment>
</net>
<net name="13" class="0">
<segment>
<pinref part="13" gate="G$1" pin="TP"/>
<pinref part="TP32" gate="G$1" pin="TP"/>
<wire x1="33.02" y1="7.62" x2="53.34" y2="7.62" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
