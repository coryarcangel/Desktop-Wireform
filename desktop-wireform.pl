#Cory Arcangel 2007-2010
#
#Generate a 3d wireform shape by picking random numbers in the XY dimensions and increacing the Z dimension. 
#


use Data::Dumper;
use XML::Writer;

#Set Z variable. This is static, because I want these sculptures to have a 'stand'
$random_number_z_old = 11.111869;
#How many point will the sculpture have?
$range_points = 7;
$random_number_points = int(rand($range_points)) + 1;

#Debugging
#$random_number_points = 8;

#Generate the string of XYZ points and save it as string. 
for ($i = 0; $i<$random_number_points; $i++)
{

$range_x = 10;
$random_number_x = rand($range_x) - 5;
$range_y = 10;
$random_number_y = rand($range_y) - 5;
$range_z = (40/$random_number_points);
$random_number_z = rand($range_z) + $random_number_z_old;
$random_number_z_old = $random_number_z;

$string = $string_old . ' ' . $random_number_x . ' ' . $random_number_y . ' ' . $random_number_z;
$string_old = $string;
}

$string = "0.0 0.000000 -0.013131 0.0 0.000000 11.111869 " . $string_old;

$weird_string_old = '0';

#Create weird string needed for file format.
for ($i = 1; $i<$random_number_points+1; $i++)
{

$weird_string = $weird_string_old . ' ' . $i . ' ' . $i;
$weird_string_old = $weird_string;

}

$weird_string = $weird_string_old . ' ' . $i . ' ';

#Debugging
#print $random_number_points;
#print "\n";
#print $weird_string;

#I copied all this crap from a DAE Sketchup outputted, so I have little idea what most of this does.
my $writer = new XML::Writer( OUTPUT => $output );

$writer->setDataMode(1);
$writer->setDataIndent(2);

$writer->xmlDecl( 'UTF-8' );
$writer->startTag( 'COLLADA', 'xmlns'=>'http://www.collada.org/2005/11/COLLADASchema', version=>'1.4.1');
	$writer->startTag('asset');
		$writer->startTag('contributor');
			$writer->startTag('authoring_tool');
			$writer->characters("Google SketchUp 7.0.10248");
			$writer->endTag(  );
		$writer->endTag(  );
		$writer->startTag('created');		
		$writer->characters("2010-02-19T04:34:41Z");
		$writer->endTag(  );
		$writer->startTag('modified');		
		$writer->characters("2010-02-19T04:34:41Z");
		$writer->endTag(  );
		$writer->emptyTag('unit', 'name'=>'inches', 'meter'=>'0.0254');
		$writer->startTag('up_axis');		
		$writer->characters("Z_UP");
		$writer->endTag(  );
	$writer->endTag(  );
	$writer->startTag('library_materials');		
		$writer->startTag('material', 'id'=>'material_0_0ID', 'name'=>'material_0_0');		
			$writer->emptyTag('instance_effect', 'url'=>'#material_0_0-effect');
		$writer->endTag(  );
	$writer->endTag(  );
	$writer->startTag('library_effects');		
		$writer->startTag( 'effect', 'id'=>'material_0_0-effect', name=>'material_0_0-effect');
			$writer->startTag( 'profile_COMMON');
				$writer->startTag( 'technique', 'sid'=>'COMMON');
					$writer->startTag( 'lambert');
						$writer->startTag( 'emission');
							$writer->startTag('color');		
							$writer->characters("0.000000 0.000000 0.000000 1");
							$writer->endTag(  );
						$writer->endTag(  );
						$writer->startTag( 'ambient');
							$writer->startTag('color');		
							$writer->characters("0.000000 0.000000 0.000000 1");
							$writer->endTag(  );
						$writer->endTag(  );
						$writer->startTag( 'diffuse');
							$writer->startTag('color');		
							$writer->characters("0.000000 0.000000 0.000000 1");
							$writer->endTag(  );
						$writer->endTag(  );
						$writer->startTag( 'transparent');
							$writer->startTag('color');		
							$writer->characters("1 1 1 1");
							$writer->endTag(  );
						$writer->endTag(  );
						$writer->startTag( 'transparency');
							$writer->startTag('float');		
							$writer->characters("0.000000");
							$writer->endTag(  );
						$writer->endTag(  );
					$writer->endTag(  );
				$writer->endTag(  );
				$writer->startTag('extra');		
					$writer->startTag('technique', 'profile'=>'GOOGLEEARTH');		
						$writer->startTag('double_sided');		
						$writer->characters("1");
						$writer->endTag(  );
					$writer->endTag(  );
				$writer->endTag(  );
			$writer->endTag(  );
		$writer->endTag(  );
	$writer->endTag(  );
	$writer->startTag('library_geometries');		
		$writer->startTag('geometry', 'id'=>'mesh1-geometry', 'name'=>'mesh1-geometry');
			$writer->startTag('mesh');		
				$writer->startTag('source', 'id'=>'mesh1-geometry-position');		
					$writer->startTag('float_array', 'id'=>'mesh1-geometry-position-array', 'count'=>($random_number_points + 2)*3);		
					$writer->characters("$string ");
					$writer->endTag(  );
					$writer->startTag('technique_common');
						$writer->startTag('accessor', 'source'=>'#mesh1-geometry-position-array', 'count'=>$random_number_points + 2, 'stride'=>'3');
							$writer->emptyTag('param', 'name'=>'X', 'type'=>'float');
							$writer->emptyTag('param', 'name'=>'Y', 'type'=>'float');
							$writer->emptyTag('param', 'name'=>'Z', 'type'=>'float');
						$writer->endTag( );
					$writer->endTag( );
				$writer->endTag(  );	
				$writer->startTag('vertices', 'id'=>'mesh1-geometry-vertex');
					$writer->emptyTag('input', 'semantic'=>'POSITION', 'source'=>'#mesh1-geometry-position');
				$writer->endTag( );
				$writer->startTag('lines', 'material'=>'material_0_0', 'count'=>$random_number_points + 1);
					$writer->emptyTag('input', 'semantic'=>'VERTEX', 'source'=>'#mesh1-geometry-vertex', 'offset'=>'0');
					$writer->startTag('p');
					$writer->characters($weird_string);
					$writer->endTag( );
				$writer->endTag( );	
			$writer->endTag(  );	
		$writer->endTag(  );
	$writer->endTag(  );
	$writer->startTag('library_visual_scenes');
	$writer->startTag('visual_scene', 'id'=>'SketchUpScene', 'name'=>'SketchUpScene');
			$writer->startTag('node', 'id'=>'Model', 'name'=>'Model');
				$writer->startTag('node', 'id'=>'mesh1', 'name'=>'mesh1');
					$writer->startTag('instance_geometry', 'url'=>'#mesh1-geometry');
						$writer->startTag('bind_material');
							$writer->startTag('technique_common');
								$writer->emptyTag('instance_material', 'symbol'=>'material_0_0', 'target'=>'#material_0_0ID');
							$writer->endTag( );
						$writer->endTag( );
					$writer->endTag( );
				$writer->endTag( );
			$writer->endTag( );
		$writer->endTag( );
	$writer->endTag( );
	$writer->startTag('scene');
		$writer->emptyTag('instance_visual_scene', 'url'=>'#SketchUpScene');
	$writer->endTag( );
$writer->endTag(  );
$writer->end(  );

