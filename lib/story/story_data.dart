import 'package:flutter/material.dart';

/// Describes a single pose cropped from a character's multi-pose sprite sheet
/// inside `assets/images/movimientos/crayon/`.
class CharacterPoseSpec {
  final String characterId; // 'companero', 'florecita', 'naranjito', 'pablito', 'maestra'
  final String sheetFileName; // Relative to `assets/images/`
  final int sheetWidth;
  final int sheetHeight;
  final int cols;
  final int rows;
  final int col;
  final int row;
  final Rect tightPixelRect;
  final bool originallyFacesRight;

  const CharacterPoseSpec({
    required this.characterId,
    required this.sheetFileName,
    required this.sheetWidth,
    required this.sheetHeight,
    required this.cols,
    required this.rows,
    required this.col,
    required this.row,
    required this.tightPixelRect,
    this.originallyFacesRight = true,
  });

  String get assetPath => 'assets/images/$sheetFileName';

  double get aspectRatio => tightPixelRect.width / tightPixelRect.height;
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/crayon/`
class CrayonPoseAtlas {
  CrayonPoseAtlas._();

  // ===========================================================================
  // 1. COMPAÑERO (`Companero crayon.png` - 1696 x 2528, Grid 2x3)
  // ===========================================================================
  /// (0,0) Dedo en la boca haciendo "Shhh, es un secreto" con crayón atrás
  static const companeroShushingSecret = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/crayon/Companero crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTRB(242, 16, 628, 814),
  );

  /// (1,0) Escondiendo las dos mitades del crayón rojo roto detrás de su espalda
  static const companeroHidingBrokenHalves = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/crayon/Companero crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTRB(998, 28, 1408, 832),
  );

  /// (0,1) Enojado señalando y culpando ("les diré a todos que fuiste tú")
  static const companeroPointingBlaming = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/crayon/Companero crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTRB(216, 862, 620, 1674),
  );

  /// (1,1) Brazos cruzados ("ya no voy a jugar contigo nunca más en el recreo")
  static const companeroArmsCrossed = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/crayon/Companero crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTRB(1070, 862, 1428, 1672),
  );

  /// (0,2) Mirando el crayón rojo roto en dos pedazos en sus manos (Intro)
  static const companeroHoldingBrokenCrayon = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/crayon/Companero crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTRB(204, 1711, 574, 2511),
  );

  // ===========================================================================
  // 2. FLORECITA (`Florecita crayon.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Preocupada con las manitas juntas frente al pecho
  static const florecitaWorriedHandsClasped = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/crayon/Florecita crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTRB(34, 34, 506, 782),
  );

  /// (1,0) Sentada triste con su pincel sin ganas de seguir pintando su flor
  static const florecitaSittingSadBrush = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/crayon/Florecita crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTRB(647, 66, 1193, 766),
    originallyFacesRight: false,
  );

  /// (2,0) Asustada con la mano en el pecho (Intro: vio todo / "Me hace sentir asustada")
  static const florecitaShockedHandChest = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/crayon/Florecita crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTRB(1194, 32, 1770, 780),
  );

  /// (0,1) Pensativa con el dedito en la barbilla
  static const florecitaThinkingChin = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/crayon/Florecita crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTRB(46, 832, 552, 1582),
    originallyFacesRight: false,
  );

  /// (1,1) Sonriendo explicando con las manos abiertas ("Los secretos divertidos son como un dibujo sorpresa...")
  static const florecitaSmilingOpenHands = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/crayon/Florecita crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTRB(645, 826, 1191, 1580),
  );

  /// (2,1) Cabizbaja y triste sintiendo que carga una piedra muy pesada
  static const florecitaSadLookingDown = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/crayon/Florecita crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTRB(1250, 826, 1686, 1584),
  );

  /// (0,2) Decidida y valiente ("Tienes muchísima razón, Naranjito. No voy a guardar algo que me hace sentir mal")
  static const florecitaDeterminedBrave = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/crayon/Florecita crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTRB(66, 1630, 582, 2380),
    originallyFacesRight: false,
  );

  /// (1,2) Contándole sinceramente a la maestra lo que pasó
  static const florecitaExplainingEarnest = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/crayon/Florecita crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTRB(639, 1632, 1097, 2378),
  );

  /// (2,2) Feliz y aliviada con las manitas juntas agradeciendo a la maestra
  static const florecitaHappyGrateful = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/crayon/Florecita crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTRB(1260, 1628, 1784, 2380),
  );

  // ===========================================================================
  // 3. NARANJITO (`Naranjito crayon.png` - 1792 x 2400, Grid 2x3)
  // ===========================================================================
  /// (0,0) Preocupado y empático ("Florecita... escúchame un momento. ¿Los secretos de verdad te hacen sentir así?")
  static const naranjitoEmpatheticAsking = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/crayon/Naranjito crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTRB(168, 28, 800, 764),
  );

  /// (1,0) Hablando con dulzura ("¿Te quitan las ganas de terminar de dibujar tu flor?")
  static const naranjitoGentleQuestion = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/crayon/Naranjito crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTRB(1068, 24, 1624, 764),
    originallyFacesRight: false,
  );

  /// (0,1) Levantando el dedito dando un consejo importante ("nunca, pero nunca, deben ser secretos obligados")
  static const naranjitoImportantAdvice = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/crayon/Naranjito crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTRB(162, 824, 834, 1558),
  );

  /// (1,1) Mano en el corazón ("Está bien hablar con un adulto en quien confíes, siempre es lo correcto")
  static const naranjitoHandOnHeart = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/crayon/Naranjito crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTRB(1062, 818, 1626, 1558),
  );

  /// (0,2) Pulgar arriba aprobando ("¡Muy bien!")
  static const naranjitoThumbsUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/crayon/Naranjito crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTRB(168, 1622, 850, 2360),
  );

  /// (1,2) Caminando feliz acompañando a Florecita y Pablito
  static const naranjitoWalkingHappy = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/crayon/Naranjito crayon.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTRB(1072, 1632, 1608, 2360),
  );

  // ===========================================================================
  // 4. PABLITO (`Pablito crayon.png` - 1696 x 2528, Grid 2x3)
  // ===========================================================================
  /// (0,0) Mostrando feliz su dinosaurio de papel con manchas azules grandes
  static const pablitoShowingDinosaur = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/crayon/Pablito crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTRB(186, 14, 668, 832),
  );

  /// (1,0) Señalando curioso ("Oye, ¿por qué ya no estás pintando tu flor roja?")
  static const pablitoPointingCurious = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/crayon/Pablito crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTRB(1014, 18, 1530, 832),
  );

  /// (0,1) Preocupado preguntándole ("¿Pasa algo malo contigo? ¿Estás cansada?")
  static const pablitoConcerned = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/crayon/Pablito crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTRB(200, 854, 620, 1674),
  );

  /// (1,1) Escuchando con empatía con manos atrás
  static const pablitoListeningCalm = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/crayon/Pablito crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTRB(1070, 864, 1478, 1672),
  );

  /// (0,2) Caminando junto a Florecita para acompañarla con la maestra
  static const pablitoWalkingWithFriend = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/crayon/Pablito crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTRB(234, 1703, 624, 2523),
  );

  /// (1,2) Saludando feliz ("Claro que sí, Florecita. Los amigos siempre se acompañan")
  static const pablitoWavingHappy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/crayon/Pablito crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTRB(1050, 1707, 1552, 2527),
  );

  // ===========================================================================
  // 5. MAESTRA (`Maestra crayon.png` - 1696 x 2528, Grid 2x3)
  // ===========================================================================
  /// (0,0) Recibiendo con cariño a Florecita frente a su escritorio
  static const maestraWelcomingWarm = CharacterPoseSpec(
    characterId: 'maestra',
    sheetFileName: 'movimientos/crayon/Maestra crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTRB(270, 38, 652, 822),
  );

  /// (1,0) Escuchando con mucha atención con la mano junto al oído
  static const maestraListeningAttentive = CharacterPoseSpec(
    characterId: 'maestra',
    sheetFileName: 'movimientos/crayon/Maestra crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTRB(1100, 48, 1438, 824),
    originallyFacesRight: false,
  );

  /// (0,1) Sorprendida y empática al escuchar que la amenazaron con un secreto
  static const maestraSurprisedEmpathetic = CharacterPoseSpec(
    characterId: 'maestra',
    sheetFileName: 'movimientos/crayon/Maestra crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTRB(254, 888, 552, 1666),
  );

  /// (1,1) Preguntando con la mano abierta ("¿Entonces quién fue, Florecita?")
  static const maestraAskingWho = CharacterPoseSpec(
    characterId: 'maestra',
    sheetFileName: 'movimientos/crayon/Maestra crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTRB(1022, 886, 1456, 1666),
    originallyFacesRight: false,
  );

  /// (0,2) Manos juntas felicitando con orgullo ("quiero felicitarte por tu honestidad")
  static const maestraProudCongratulating = CharacterPoseSpec(
    characterId: 'maestra',
    sheetFileName: 'movimientos/crayon/Maestra crayon.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTRB(268, 1733, 556, 2515),
  );
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/nube/`
/// for the 2nd story ("La nube de tormenta" / Día de lluvia).
class NubePoseAtlas {
  NubePoseAtlas._();

  // ===========================================================================
  // 1. PABLITO (`Pablito nube.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Enojado con los brazos cruzados mirando hacia la lluvia
  static const pablitoAngryArmsCrossed = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/nube/Pablito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(102, 13, 366, 774),
  );

  /// (1,0) Enojado reclamando con los puños cerrados ("¡Yo quería salir a correr al patio grande!")
  static const pablitoAngryShoutingFists = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/nube/Pablito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(690, 17, 379, 770),
  );

  /// (2,0) Enojado sosteniendo su pelota nueva de colores ("¡Yo quería usar mi pelota nueva de colores en el pasto...!")
  static const pablitoAngryHoldingBall = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/nube/Pablito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1296, 15, 369, 772),
    originallyFacesRight: false,
  );

  /// (0,1) Frustrado dando una patada al aire ("o patear las sillas muy fuerte para que todos vean que estoy enojado")
  static const pablitoFrustratedKicking = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/nube/Pablito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(104, 815, 374, 766),
    originallyFacesRight: false,
  );

  /// (1,1) Triste y cabizbajo abrazando su pelota de colores ("Y también estoy un poquito triste, porque mi pelota no puede rodar...")
  static const pablitoSadHuggingBall = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/nube/Pablito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(739, 830, 342, 757),
  );

  /// (2,1) Mano en el pecho sintiendo lo que pasa adentro de su cuerpo
  static const pablitoHandOnChestReflecting = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/nube/Pablito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1314, 814, 348, 774),
  );

  /// (0,2) Ojos cerrados y manos en la pancita respirando y calmándose
  static const pablitoCalmingBreathing = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/nube/Pablito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(111, 1613, 341, 770),
  );

  /// (1,2) Emocionado levantando ambos brazos ("¿Una cueva gigante de verdad para nosotros solos? ¡Sí, claro que sí, Florecita!")
  static const pablitoExcitedArmsUp = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/nube/Pablito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(637, 1612, 530, 771),
  );

  /// (2,2) Caminando feliz cargando un cojín grande de colores ("Yo traigo todos los cojines grandes del rincón de lectura...")
  static const pablitoCarryingCushionHappy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/nube/Pablito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1305, 1613, 397, 765),
  );

  // ===========================================================================
  // 2. NARANJITO (`Naranjito nube.png` - 1792 x 2400, Grid 2x3)
  // ===========================================================================
  /// (0,0) Empático y comprensivo preguntándole qué siente su cuerpo
  static const naranjitoEmpatheticAsking = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/nube/Naranjito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(143, 48, 620, 709),
  );

  /// (1,0) Haciendo forma de nube sobre su cabecita ("Parece que tienes una nube de tormenta gris adentro de ti, Pablito")
  static const naranjitoCloudOverHead = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/nube/Naranjito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1067, 44, 589, 712),
  );

  /// (0,1) Mano en el pecho hablando con calidez ("Cuando sabemos qué sentimos y le decimos su nombre...")
  static const naranjitoWarmSpeakingHandChest = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/nube/Naranjito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(141, 833, 660, 724),
  );

  /// (1,1) Sosteniendo un paraguas naranja ("Conocer cómo se llama tu tormenta te ayuda a encontrar el mejor paraguas, Pablito")
  static const naranjitoHoldingUmbrella = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/nube/Naranjito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1052, 835, 696, 716),
  );

  /// (0,2) Levantando el dedito con ternura explicando que es normal sentirse enojado
  static const naranjitoGentleAdviceFinger = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/nube/Naranjito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(160, 1634, 649, 721),
  );

  /// (1,2) Feliz con el pulgar arriba celebrando la idea de la cueva
  static const naranjitoHappyThumbsUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/nube/Naranjito nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1078, 1633, 636, 723),
  );

  // ===========================================================================
  // 3. FLORECITA (`Florecita nube.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Caminando hacia Pablito ("Pablito, te escuché hablar desde allá...")
  static const florecitaWalkingApproaching = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/nube/Florecita nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(49, 37, 442, 757),
  );

  /// (1,0) Invitando con ambas manos abiertas ("¿me ayudas a construir una cueva gigante aquí adentro?")
  static const florecitaInvitingHandsOpen = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/nube/Florecita nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(629, 37, 492, 756),
  );

  /// (2,0) Mano en la frente como exploradora/pirata buscando un tesoro escondido
  static const florecitaExplorerSalute = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/nube/Florecita nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1299, 38, 491, 753),
    originallyFacesRight: false,
  );

  /// (0,1) Señalando hacia las cobijas largas y las sillas de plástico
  static const florecitaPointingBlankets = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/nube/Florecita nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(34, 838, 537, 748),
  );

  /// (1,1) De pie sonriendo con dulzura
  static const florecitaSmilingStanding = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/nube/Florecita nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(661, 835, 533, 751),
    originallyFacesRight: false,
  );

  /// (2,1) Contando emocionada con la manita cerca de la boca ("como si fuera un tesoro pirata escondido")
  static const florecitaCallingHandMouth = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/nube/Florecita nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1194, 835, 585, 751),
    originallyFacesRight: false,
  );

  /// (0,2) Señalando entusiasmada el rincón para armar la cueva
  static const florecitaPointingExcited = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/nube/Florecita nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(36, 1626, 519, 744),
  );

  /// (1,2) Mostrando con la mano abierta el espacio del salón
  static const florecitaPresentingOpenHand = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/nube/Florecita nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(627, 1628, 567, 741),
    originallyFacesRight: false,
  );

  /// (2,2) Aplaudiendo feliz cuando Pablito acepta construir la cueva gigante
  static const florecitaClappingHappy = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/nube/Florecita nube.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1194, 1628, 570, 741),
    originallyFacesRight: false,
  );
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/burbuja/`
/// for the 3rd story ("La burbuja personal" / Fiesta en el patio).
class BurbujaPoseAtlas {
  BurbujaPoseAtlas._();

  // ===========================================================================
  // 1. TÍA (`Tia burbuja.png` - 2752 x 1536, Top row 3 poses, Bottom row 4 poses)
  // ===========================================================================
  /// (0,0) Manos en las mejillas encantada ("¡Ay, mi niña hermosa, cuánto has crecido...!")
  static const tiaDelightedCheeks = CharacterPoseSpec(
    characterId: 'tia',
    sheetFileName: 'movimientos/burbuja/Tia burbuja.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 3,
    rows: 2,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(157, 25, 366, 729),
  );

  /// (1,0) Brazos completamente abiertos para dar un abrazo de oso muy apretado
  static const tiaBearHugArmsWide = CharacterPoseSpec(
    characterId: 'tia',
    sheetFileName: 'movimientos/burbuja/Tia burbuja.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 3,
    rows: 2,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1073, 20, 610, 731),
  );

  /// (2,0) Llamando con la mano ("¡Ven aquí rápido para apachurrarte con todas mis fuerzas!")
  static const tiaBeckoningComeHere = CharacterPoseSpec(
    characterId: 'tia',
    sheetFileName: 'movimientos/burbuja/Tia burbuja.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 3,
    rows: 2,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(2195, 35, 466, 719),
    originallyFacesRight: false,
  );

  /// (0,1) Escuchando con cariño y atención a Florecita
  static const tiaListeningWarmly = CharacterPoseSpec(
    characterId: 'tia',
    sheetFileName: 'movimientos/burbuja/Tia burbuja.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 4,
    rows: 2,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(166, 785, 330, 739),
  );

  /// (1,1) Mano en el pecho comprendiendo con amor ("¡Claro que sí, mi niña hermosa! Tienes toda la razón...")
  static const tiaUnderstandingHandOnHeart = CharacterPoseSpec(
    characterId: 'tia',
    sheetFileName: 'movimientos/burbuja/Tia burbuja.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 4,
    rows: 2,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(840, 785, 325, 739),
  );

  /// (2,1) Levantando la mano para chocar esos cinco ("¡Choca esos cinco ahora mismo...!")
  static const tiaHighFiveRaised = CharacterPoseSpec(
    characterId: 'tia',
    sheetFileName: 'movimientos/burbuja/Tia burbuja.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 4,
    rows: 2,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1574, 784, 376, 740),
    originallyFacesRight: false,
  );

  /// (3,1) Señalando feliz hacia la mesa del pastel ("¡...y vamos a comer pastel!")
  static const tiaPointingCakeLaughing = CharacterPoseSpec(
    characterId: 'tia',
    sheetFileName: 'movimientos/burbuja/Tia burbuja.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 4,
    rows: 2,
    col: 3,
    row: 1,
    tightPixelRect: Rect.fromLTWH(2165, 786, 450, 738),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 2. FLORECITA (`Florecita burbuja.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Preocupada con las manitas juntas ("Pero me da mucha pena decirle que no quiero ese abrazo gigante")
  static const florecitaWorriedClasped = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/burbuja/Florecita burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(38, 32, 467, 766),
  );

  /// (1,0) Apenada mirando hacia abajo ("No quiero que se enoje conmigo ni que piense que no la quiero...")
  static const florecitaShyLookingDown = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/burbuja/Florecita burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(687, 32, 499, 764),
  );

  /// (2,0) Pensativa con el dedito en la barbilla escuchando a Naranjito
  static const florecitaThinkingChin = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/burbuja/Florecita burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1266, 29, 512, 771),
    originallyFacesRight: false,
  );

  /// (0,1) Mano en el pecho con seguridad ("Sí, Naranjito. Es mi propio cuerpo y yo decido")
  static const florecitaHandOnChestMyBody = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/burbuja/Florecita burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(90, 825, 507, 769),
    originallyFacesRight: false,
  );

  /// (1,1) Incómoda con una mano en la pancita y otra cerca de la boca ("pero sus abrazos me lastiman")
  static const florecitaUncomfortableTummy = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/burbuja/Florecita burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(597, 824, 587, 771),
  );

  /// (2,1) Hablando con respeto con ambas manos abiertas ("Hola, tía. Qué bueno verte. Hoy no quiero abrazos de oso...")
  static const florecitaSpeakingRespectfully = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/burbuja/Florecita burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1235, 826, 542, 769),
    originallyFacesRight: false,
  );

  /// (0,2) Levantando la mano para chocar esos cinco ("Mejor te saludo chocando las manos súper fuerte...")
  static const florecitaHighFiveRaised = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/burbuja/Florecita burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(42, 1624, 516, 761),
    originallyFacesRight: false,
  );

  /// (1,2) Saludando con la mano abierta con alegría
  static const florecitaWelcomingOpenHand = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/burbuja/Florecita burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(620, 1623, 574, 762),
  );

  /// (2,2) Feliz y emocionada con las manitas junto a las mejillas celebrando
  static const florecitaHappyHandsCheeks = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/burbuja/Florecita burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1194, 1625, 581, 762),
  );

  // ===========================================================================
  // 3. NARANJITO (`Naranjito burbuja.png` - 1792 x 2400, Grid 2x3)
  // ===========================================================================
  /// (0,0) Mostrando el arco brillante de la burbuja personal ("Recuerda que el espacio cerquita de ti es tu burbuja personal...")
  static const naranjitoHoldingBubble = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/burbuja/Naranjito burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(163, 30, 569, 737),
  );

  /// (1,0) Levantando el dedito firme ("Nadie, absolutamente nadie, puede entrar a tu burbuja sin tu permiso")
  static const naranjitoFirmFingerUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/burbuja/Naranjito burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1009, 31, 651, 736),
    originallyFacesRight: false,
  );

  /// (0,1) Escuchando con empatía las dudas de Florecita
  static const naranjitoEmpatheticListening = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/burbuja/Naranjito burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(164, 827, 563, 740),
  );

  /// (1,1) Mano en el corazón hablando con ternura ("Las personas que te quieren de verdad, como tu familia, van a entender perfectamente...")
  static const naranjitoWarmHandOnHeart = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/burbuja/Naranjito burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(994, 829, 666, 737),
    originallyFacesRight: false,
  );

  /// (0,2) Feliz con el pulgar arriba
  static const naranjitoHappyThumbsUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/burbuja/Naranjito burbuja.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(160, 1631, 649, 737),
  );

  // ===========================================================================
  // 4. PABLITO (`Pablito burbuja.png` - 1696 x 2528, Grid 2x2)
  // ===========================================================================
  /// (0,0) Saludando contento con la mano arriba ("¡Hola, tía de Florecita!")
  static const pablitoWavingHappy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/burbuja/Pablito burbuja.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 2,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(39, 27, 666, 1202),
    originallyFacesRight: false,
  );

  /// (1,0) Extendiendo la mano para chocar esos cinco con la tía
  static const pablitoHighFiveGreeting = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/burbuja/Pablito burbuja.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 2,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(903, 30, 729, 1203),
    originallyFacesRight: false,
  );

  /// (0,1) Señalando entusiasmado hacia el pastel ("¡Qué bueno que vino a la fiesta de hoy, hay mucho pastel!")
  static const pablitoPointingCake = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/burbuja/Pablito burbuja.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 2,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(81, 1304, 740, 1199),
  );

  /// (1,1) Saltando de alegría con ambos brazos arriba
  static const pablitoJumpingJoy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/burbuja/Pablito burbuja.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 2,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(905, 1302, 744, 1179),
  );
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/papalote/`
/// for the 4th story ("El papalote en el árbol").
class PapalotePoseAtlas {
  PapalotePoseAtlas._();

  // ===========================================================================
  // 1. PABLITO (`Pablito papalote.png` - 1696 x 2528, Grid 3x3)
  // ===========================================================================
  /// (0,0) Estirándose de puntitas intentando alcanzar la cuerda del papalote
  static const pablitoReachingUpOnTiptoes = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/papalote/Pablito papalote.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(54, 10, 459, 813),
  );

  /// (1,0) Manos en la cintura orgulloso ("¡Tengo que hacerlo yo solo para demostrarles...!")
  static const pablitoHandsOnHipsProud = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/papalote/Pablito papalote.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(649, 11, 396, 814),
  );

  /// (2,0) Brazos cruzados obstinado ("Pero si voy a pedir ayuda, todos los niños van a pensar que soy pequeño...")
  static const pablitoStubbornArmsCrossed = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/papalote/Pablito papalote.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1216, 9, 376, 816),
  );

  /// (0,1) Manitas juntas reflexionando con humildad
  static const pablitoShyHandsClasped = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/papalote/Pablito papalote.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(100, 854, 364, 815),
    originallyFacesRight: false,
  );

  /// (1,1) Pensativo con la mano en la barbilla escuchando el consejo de Naranjito
  static const pablitoThinkingChin = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/papalote/Pablito papalote.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(663, 858, 361, 811),
    originallyFacesRight: false,
  );

  /// (2,1) Asustado porque el bote se movía mucho y casi se resbala
  static const pablitoScaredAlmostSlipped = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/papalote/Pablito papalote.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1237, 858, 373, 811),
    originallyFacesRight: false,
  );

  /// (0,2) Caminando con cuidado junto a Florecita para pedir ayuda
  static const pablitoWalkingCarefully = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/papalote/Pablito papalote.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(104, 1702, 381, 814),
  );

  /// (1,2) Pidiendo ayuda señalando hacia arriba ("¿Me acompañas a pedirle ayuda a tu papá, por favor?")
  static const pablitoAskingForHelpPointing = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/papalote/Pablito papalote.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(657, 1702, 462, 826),
  );

  /// (2,2) Sosteniendo feliz su papalote de colores ("Muchas gracias señor, ahora podremos seguir jugando")
  static const pablitoHoldingKiteHappy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/papalote/Pablito papalote.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1235, 1703, 389, 816),
  );

  // ===========================================================================
  // 2. NARANJITO (`Naranjito papalote.png` - 1792 x 2400, Grid 2x3)
  // ===========================================================================
  /// (0,0) Preocupado mirando hacia arriba con manita en la cabeza ("Mmm... Pablito, escúchame bien...")
  static const naranjitoWorriedLookingUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/papalote/Naranjito papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(161, 29, 607, 739),
    originallyFacesRight: false,
  );

  /// (1,0) Levantando la manita pidiendo calma y precaución
  static const naranjitoStopWaitHand = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/papalote/Naranjito papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1007, 30, 624, 738),
    originallyFacesRight: false,
  );

  /// (0,1) Dedito arriba enseñando ("Los niños más grandes y valientes no son los que hacen todo solos siempre...")
  static const naranjitoWiseFingerUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/papalote/Naranjito papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(161, 831, 679, 736),
  );

  /// (1,1) Mano en el corazón ("Pedir ayuda también es de valientes")
  static const naranjitoWarmHandOnHeart = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/papalote/Naranjito papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1061, 831, 675, 736),
  );

  /// (0,2) Feliz con el pulgar arriba
  static const naranjitoHappyThumbsUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/papalote/Naranjito papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(162, 1630, 670, 737),
  );

  // ===========================================================================
  // 3. FLORECITA (`Florecita papalote.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Llamando con las manos en la boca ("¡Pablito, bájate de ahí ahora mismo, por favor!")
  static const florecitaCallingHandsMouth = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/papalote/Florecita papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(55, 31, 494, 749),
    originallyFacesRight: false,
  );

  /// (1,0) Preocupada extendiendo la mano ("Ese bote de basura se mueve mucho, se va a voltear...")
  static const florecitaWorriedStopHand = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/papalote/Florecita papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(665, 32, 497, 748),
    originallyFacesRight: false,
  );

  /// (2,0) Señalando hacia la banca azul ("Mi papá está leyendo su libro muy cerca de aquí en la banca azul...")
  static const florecitaPointingToBench = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/papalote/Florecita papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1230, 29, 548, 750),
  );

  /// (0,1) Aceptando con la mano abierta ("Claro que sí, Pablito, vamos a hablar con mi papá...")
  static const florecitaAgreeingOpenHand = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/papalote/Florecita papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(57, 834, 512, 742),
    originallyFacesRight: false,
  );

  /// (1,1) Caminando hacia su papá
  static const florecitaWalkingToDad = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/papalote/Florecita papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(662, 826, 438, 754),
  );

  /// (2,1) Señalando hacia arriba al árbol ("Hola papá, ¿nos ayudas a bajar el papalote de Pablito?...")
  static const florecitaPointingUpAtKite = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/papalote/Florecita papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1241, 841, 491, 736),
  );

  /// (1,2) Feliz y agradecida con las manitas juntas
  static const florecitaHappyGratefulHands = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/papalote/Florecita papalote.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(673, 1637, 527, 738),
  );

  // ===========================================================================
  // 4. PAPÁ - Hoja 1 (`papa papalote1.png` - 1325 x 1968, Grid 2x2)
  // ===========================================================================
  /// (0,0) Sentado leyendo su libro en la banca azul
  static const papaSittingReadingBook = CharacterPoseSpec(
    characterId: 'papa',
    sheetFileName: 'movimientos/papalote/papa papalote1.png',
    sheetWidth: 1325,
    sheetHeight: 1968,
    cols: 2,
    rows: 2,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(79, 19, 432, 965),
  );

  /// (1,0) Sentado con su libro mirando y sonriendo con cariño a Florecita y Pablito
  static const papaSittingLookingUpSmiling = CharacterPoseSpec(
    characterId: 'papa',
    sheetFileName: 'movimientos/papalote/papa papalote1.png',
    sheetWidth: 1325,
    sheetHeight: 1968,
    cols: 2,
    rows: 2,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(802, 15, 447, 969),
    originallyFacesRight: false,
  );

  /// (0,1) De pie sonriendo con calidez
  static const papaStandingWarmSmile = CharacterPoseSpec(
    characterId: 'papa',
    sheetFileName: 'movimientos/papalote/papa papalote1.png',
    sheetWidth: 1325,
    sheetHeight: 1968,
    cols: 2,
    rows: 2,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(72, 984, 505, 969),
  );

  /// (1,1) Estirando el brazo hacia arriba para bajar el papalote fácilmente ("Claro que sí hija, vamos a bajar el papalote...")
  static const papaReachingUpForKite = CharacterPoseSpec(
    characterId: 'papa',
    sheetFileName: 'movimientos/papalote/papa papalote1.png',
    sheetWidth: 1325,
    sheetHeight: 1968,
    cols: 2,
    rows: 2,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(754, 984, 510, 969),
  );

  // ===========================================================================
  // 5. PAPÁ - Hoja 2 (`Papa papalote2.png` - 1696 x 2528, 3 poses)
  // ===========================================================================
  /// (0,0) Entregando el papalote en la mano ("Aquí tienen su papalote")
  static const papaHandingKiteToPablito = CharacterPoseSpec(
    characterId: 'papa',
    sheetFileName: 'movimientos/papalote/Papa papalote2.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 2,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(196, 64, 647, 1210),
  );

  /// (1,0) Mano en el pecho agradeciendo la confianza ("Claro que sí, saben que siempre pueden contar conmigo...")
  static const papaHandOnHeartProud = CharacterPoseSpec(
    characterId: 'papa',
    sheetFileName: 'movimientos/papalote/Papa papalote2.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 2,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1079, 60, 475, 1213),
  );

  /// (0,1) Mano en la frente aliviado ("no quiero imaginarme lo que hubiera pasado si se cayeran...")
  static const papaRelievedHandForehead = CharacterPoseSpec(
    characterId: 'papa',
    sheetFileName: 'movimientos/papalote/Papa papalote2.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 2,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(580, 1317, 542, 1195),
    originallyFacesRight: false,
  );
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/companera/`
/// for the 5th story ("La niña nueva").
class CompaneraPoseAtlas {
  CompaneraPoseAtlas._();

  // ===========================================================================
  // 1. FLORECITA (`Florecita companera.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Señalando hacia la banca ("Pablito, mira hacia allá. Esa niña nueva con la mochila de estrellitas no juega con nadie...")
  static const florecitaPointingRight = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/companera/Florecita companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(37, 30, 511, 749),
  );

  /// (1,0) Pensativa con la mano en la barbilla ("Seguro prefiere estar completamente sola...")
  static const florecitaThinkingHandOnChin = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/companera/Florecita companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(669, 32, 495, 748),
    originallyFacesRight: false,
  );

  /// (2,0) Manitas en el pecho recordando su miedo ("Cuando yo llegué a esta escuela el primer día, me dio muchísimo miedo...")
  static const florecitaSadHandsChest = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/companera/Florecita companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1254, 30, 510, 750),
    originallyFacesRight: false,
  );

  /// (0,1) Sonrisa tierna recordando cuando Pablito le habló por primera vez ("Tenía muchas ganas de llorar del susto hasta que tú me hablaste...")
  static const florecitaWarmSmileLookingUp = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/companera/Florecita companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(76, 836, 490, 742),
    originallyFacesRight: false,
  );

  /// (1,1) Decidida llamando con la mano ("Pablito, deja tus juguetes un momento y acompáñame. Vamos a invitarla a jugar...")
  static const florecitaBeckoningComeWithMe = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/companera/Florecita companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(659, 826, 480, 753),
    originallyFacesRight: false,
  );

  /// (2,1) Caminando hacia la banca / mesa con sonrisa amable
  static const florecitaWalkingRight = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/companera/Florecita companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1252, 833, 438, 752),
  );

  /// (0,2) Saludando con la mano arriba ("Hola, ¿cómo estás? Me llamo Florecita...")
  static const florecitaWavingHello = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/companera/Florecita companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(41, 1634, 528, 742),
    originallyFacesRight: false,
  );

  /// (1,2) Presentando con la mano abierta ("...y él es mi mejor amigo Pablito.")
  static const florecitaPresentingGesture = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/companera/Florecita companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(677, 1633, 503, 744),
    originallyFacesRight: false,
  );

  /// (2,2) Extendiendo la mano con cariño ("¿quieres ser nuestra amiga?")
  static const florecitaOfferingHandToFriend = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/companera/Florecita companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1256, 1632, 526, 744),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 2. NARANJITO (`Naranjito companera.png` - 1792 x 2400, Grid 2x3)
  // ===========================================================================
  /// (0,0) Sonrisa empática ("A veces, estar solo no es porque uno quiera estarlo, sino porque da mucha, mucha pena...")
  static const naranjitoEmpatheticSmile = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/companera/Naranjito companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(199, 41, 494, 706),
  );

  /// (1,0) Pensativo con manita en la barbilla ("Piensa un ratito, Florecita... ¿Cómo te gustaría que te trataran a ti...?")
  static const naranjitoPensiveHandOnChin = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/companera/Naranjito companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1082, 43, 523, 703),
    originallyFacesRight: false,
  );

  /// (0,1) Mano en el corazón escuchando con ternura
  static const naranjitoHandOnHeartGesture = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/companera/Naranjito companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(178, 833, 577, 701),
  );

  /// (1,1) Señalando su gran sonrisa ("Un pequeño saludo y una sonrisa bonita pueden cambiarle el día completo...")
  static const naranjitoPointingToBigSmile = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/companera/Naranjito companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1075, 834, 540, 710),
  );

  /// (0,2) Feliz con el pulgar arriba
  static const naranjitoHappyThumbsUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/companera/Naranjito companera.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(169, 1636, 642, 707),
  );

  // ===========================================================================
  // 3. PABLITO (`Pablito companera.png` - 1696 x 2528, Grid 3x3)
  // ===========================================================================
  /// (0,0) Sosteniendo feliz su dinosaurio de juguete
  static const pablitoHoldingDinoHappy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/companera/Pablito companera.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(77, 26, 412, 799),
  );

  /// (1,0) Dejando su dinosaurio y mirando hacia la niña nueva ("Pablito, deja tus juguetes un momento y acompáñame")
  static const pablitoSettingDinoDownLooking = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/companera/Pablito companera.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(623, 24, 459, 802),
  );

  /// (2,0) Caminando contento junto a Florecita para invitarla
  static const pablitoWalkingRight = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/companera/Pablito companera.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1208, 23, 406, 805),
  );

  /// (0,1) Saludando con la mano arriba y gran sonrisa
  static const pablitoWavingHello = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/companera/Pablito companera.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(42, 866, 448, 807),
    originallyFacesRight: false,
  );

  /// (1,1) Mostrando su carrito de juguete ("tenemos dinosaurios, carritos, pelotas, bueno de todos los juguetes… ¿Qué quieres jugar?")
  static const pablitoShowingToyCar = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/companera/Pablito companera.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(613, 866, 544, 807),
  );

  /// (2,1) Escuchando con empatía con las manos abiertas
  static const pablitoEmpatheticOpenHands = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/companera/Pablito companera.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1195, 867, 406, 806),
    originallyFacesRight: false,
  );

  /// (0,2) Ambos brazos arriba emocionado ("¡siii, acepta ser nuestra amiga para que juguemos todos los juegos del mundo!")
  static const pablitoArmsRaisedExcited = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/companera/Pablito companera.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(115, 1710, 605, 810),
  );

  // ===========================================================================
  // 4. COMPAÑERITA (`companera1.png` - 1792 x 2400, Grid 3x2 & `companera2.png` - 2528 x 1696, Grid 2x1)
  // ===========================================================================
  /// `companera1.png` (0,0) Sentada solita y tímida en la banca mirando hacia abajo
  static const companeraSittingOnBenchShy = CharacterPoseSpec(
    characterId: 'companera',
    sheetFileName: 'movimientos/companera/companera1.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 2,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(14, 98, 529, 944),
  );

  /// `companera1.png` (1,0) De pie tímida con las manitas juntas mirando hacia abajo
  static const companeraStandingShyHandsClasped = CharacterPoseSpec(
    characterId: 'companera',
    sheetFileName: 'movimientos/companera/companera1.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 2,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(624, 83, 559, 1006),
    originallyFacesRight: false,
  );

  /// `companera1.png` (2,0) De pie sorprendida cuando Florecita y Pablito la saludan
  static const companeraStandingSurprised = CharacterPoseSpec(
    characterId: 'companera',
    sheetFileName: 'movimientos/companera/companera1.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 2,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1213, 83, 559, 1007),
    originallyFacesRight: false,
  );

  /// `companera1.png` (0,1) Saludando tímidamente con la mano ("Hola Florecita, hola Pablito, estoy muy bien gracias ¿y ustedes?")
  static const companeraWavingShyly = CharacterPoseSpec(
    characterId: 'companera',
    sheetFileName: 'movimientos/companera/companera1.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 2,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(23, 1238, 575, 1044),
  );

  /// `companera1.png` (1,1) Manitas juntas en el pecho emocionada y agradecida
  static const companeraHappyHandsTogether = CharacterPoseSpec(
    characterId: 'companera',
    sheetFileName: 'movimientos/companera/companera1.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 2,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(620, 1238, 574, 1043),
    originallyFacesRight: false,
  );

  /// `companera1.png` (2,1) Dedito en la barbilla con timidez ("me gustaría jugar a todo pero me da pena porque es mi primer día")
  static const companeraFingerOnChinShy = CharacterPoseSpec(
    characterId: 'companera',
    sheetFileName: 'movimientos/companera/companera1.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 2,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1208, 1235, 571, 1047),
  );

  /// `companera2.png` (0,0) Caminando contenta hacia la mesa de juegos
  static const companeraWalkingHappy = CharacterPoseSpec(
    characterId: 'companera',
    sheetFileName: 'movimientos/companera/companera2.png',
    sheetWidth: 2528,
    sheetHeight: 1696,
    cols: 2,
    rows: 1,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(216, 198, 738, 1365),
  );

  /// `companera2.png` (1,0) Brazos completamente abiertos feliz ("¡Sí quiero ser su amiga!")
  static const companeraArmsWideOpenHappy = CharacterPoseSpec(
    characterId: 'companera',
    sheetFileName: 'movimientos/companera/companera2.png',
    sheetWidth: 2528,
    sheetHeight: 1696,
    cols: 2,
    rows: 1,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1342, 208, 1075, 1340),
    originallyFacesRight: false,
  );
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/juegos/`
/// for the 6th story ("Juegos seguros en el patio grande").
class JuegosPoseAtlas {
  JuegosPoseAtlas._();

  // ===========================================================================
  // 1. NIÑO MAYOR (`Companero juegos.png` - 2528 x 1696, Grid 3x2)
  // ===========================================================================
  /// (0,0) Corriendo rápido y estirando la mano para empujar/atrapar ("¡Las traes, te toqué! ¡Te atrapé súper rápido!")
  static const ninoMayorRunningTagging = CharacterPoseSpec(
    characterId: 'nino_mayor',
    sheetFileName: 'movimientos/juegos/Companero juegos.png',
    sheetWidth: 2528,
    sheetHeight: 1696,
    cols: 3,
    rows: 2,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(203, 69, 582, 761),
  );

  /// (1,0) Señalando con sonrisa burlona ("¡Así se juega a atrapar aquí en el patio grande!")
  static const ninoMayorPointingBoastful = CharacterPoseSpec(
    characterId: 'nino_mayor',
    sheetFileName: 'movimientos/juegos/Companero juegos.png',
    sheetWidth: 2528,
    sheetHeight: 1696,
    cols: 3,
    rows: 2,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1040, 44, 417, 790),
    originallyFacesRight: false,
  );

  /// (2,0) Manos en la cintura mirando con desdén ("Si vas a llorar, mejor vete a otro lado.")
  static const ninoMayorHandsOnHipsDismissive = CharacterPoseSpec(
    characterId: 'nino_mayor',
    sheetFileName: 'movimientos/juegos/Companero juegos.png',
    sheetWidth: 2528,
    sheetHeight: 1696,
    cols: 3,
    rows: 2,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1931, 44, 336, 787),
  );

  /// (0,1) Encogiéndose de hombros con ambas manos abiertas ("¡No exageres! ¡Solo estábamos jugando!")
  static const ninoMayorShruggingExaggerating = CharacterPoseSpec(
    characterId: 'nino_mayor',
    sheetFileName: 'movimientos/juegos/Companero juegos.png',
    sheetWidth: 2528,
    sheetHeight: 1696,
    cols: 3,
    rows: 2,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(204, 875, 471, 796),
  );

  /// (1,1) Brazos cruzados molesto ("¡Pero todos los niños mayores juegan así!")
  static const ninoMayorArmsCrossedFrowning = CharacterPoseSpec(
    characterId: 'nino_mayor',
    sheetFileName: 'movimientos/juegos/Companero juegos.png',
    sheetWidth: 2528,
    sheetHeight: 1696,
    cols: 3,
    rows: 2,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1107, 874, 329, 798),
    originallyFacesRight: false,
  );

  /// (2,1) Mano en la barbilla reflexionando sobre lo que le dijeron Pablito y Florecita
  static const ninoMayorThinkingChinReflecting = CharacterPoseSpec(
    characterId: 'nino_mayor',
    sheetFileName: 'movimientos/juegos/Companero juegos.png',
    sheetWidth: 2528,
    sheetHeight: 1696,
    cols: 3,
    rows: 2,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1942, 879, 320, 793),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 2. PABLITO (`Pablito juegos.png` - 1696 x 2528, Grid 3x3)
  // ===========================================================================
  /// (0,0) Corriendo feliz jugando en el patio
  static const pablitoRunningHappy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/juegos/Pablito juegos.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(65, 9, 474, 818),
  );

  /// (1,0) Perdiendo el equilibrio asustado cuando el niño mayor lo empuja
  static const pablitoFallingPushed = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/juegos/Pablito juegos.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(592, 9, 563, 815),
  );

  /// (2,0) Sentado en el suelo agarrándose la rodilla con mucho dolor ("¡Ay! ¡Mi rodilla! ¿Por qué me empujaste tan fuerte?")
  static const pablitoSittingHurtKnee = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/juegos/Pablito juegos.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1170, 36, 480, 763),
    originallyFacesRight: false,
  );

  /// (0,1) De pie con lagrimitas y la rodilla raspada ("No, Naranjito. A mí no me dio nada de risa. Me dolió muchísimo la rodilla...")
  static const pablitoStandingTearsHurtKnee = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/juegos/Pablito juegos.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(102, 855, 391, 822),
  );

  /// (1,1) Señalando con firmeza ("¡Tienes razón! No quiero volver a jugar así.")
  static const pablitoPointingFirm = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/juegos/Pablito juegos.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(644, 851, 473, 824),
  );

  /// (2,1) Contándole a Florecita lo que pasó con la rodilla lastimada ("Me duele la rodilla, Florecita. El niño mayor me empujó muy fuerte...")
  static const pablitoExplainingSadHandsOpen = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/juegos/Pablito juegos.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1225, 843, 386, 830),
    originallyFacesRight: false,
  );

  /// (0,2) Levantando la palma diciendo "¡Alto!" con seguridad ("No importa si eres mayor o pequeño. No me gusta que me empujes. Si quieres jugar conmigo, tienes que respetarme.")
  static const pablitoStopHandFirm = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/juegos/Pablito juegos.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(82, 1698, 400, 830),
    originallyFacesRight: false,
  );

  /// (1,2) Caminando decidido hacia el salón de la maestra ("Vamos a contarle a la maestra lo que pasó.")
  static const pablitoWalkingDetermined = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/juegos/Pablito juegos.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(654, 1697, 426, 827),
  );

  /// (2,2) Saltando de alegría con ambos brazos arriba
  static const pablitoJumpingHappy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/juegos/Pablito juegos.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1173, 1696, 480, 821),
  );

  // ===========================================================================
  // 3. FLORECITA (`Florecita juegos.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Acercándose rápido preocupada ("¡Pablito! ¿Estás bien? Te vi caer desde los columpios.")
  static const florecitaRunningWorried = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/juegos/Florecita juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(53, 29, 482, 750),
  );

  /// (1,0) Manitas en el pecho preocupada escuchando a Pablito
  static const florecitaWorriedHandsChest = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/juegos/Florecita juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(659, 30, 504, 749),
    originallyFacesRight: false,
  );

  /// (2,0) Extendiendo la mano con ternura para ayudar ("¿Necesitas ayuda?")
  static const florecitaHelpingHandDown = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/juegos/Florecita juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1276, 36, 508, 744),
    originallyFacesRight: false,
  );

  /// (0,1) Levantando el dedito firme ("¡Eso no está bien! Los juegos deben ser divertidos y seguros.")
  static const florecitaFirmFingerUp = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/juegos/Florecita juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(66, 829, 496, 750),
    originallyFacesRight: false,
  );

  /// (1,1) Explicando con ambas manos ("Nadie tiene que empujar ni lastimar a sus amigos para demostrar que es más fuerte.")
  static const florecitaExplainingBothHands = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/juegos/Florecita juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(649, 825, 498, 756),
  );

  /// (2,1) Sonriendo y apoyando a Pablito con las manos abiertas
  static const florecitaEncouragingSmile = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/juegos/Florecita juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1256, 831, 530, 750),
    originallyFacesRight: false,
  );

  /// (0,2) Extendiendo la mano hacia un lado ("Y si alguien se lastima, debemos ayudarlo, no burlarnos de él.")
  static const florecitaExtendingHandSide = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/juegos/Florecita juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(46, 1630, 506, 748),
  );

  /// (1,2) Señalando con calidez hacia el salón de la maestra
  static const florecitaPresentingWarmly = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/juegos/Florecita juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(638, 1630, 540, 746),
    originallyFacesRight: false,
  );

  /// (2,2) Manitas juntas en el pecho sonriendo orgullosa y feliz
  static const florecitaHappyHandsChest = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/juegos/Florecita juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1268, 1631, 506, 747),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 4. NARANJITO (`Naranjito juegos.png` - 1792 x 2400, Grid 2x3)
  // ===========================================================================
  /// (0,0) Saltando feliz con ambos brazos arriba ("¡Qué divertido es jugar con los amigos! Podemos correr, saltar y reír muchísimo.")
  static const naranjitoJumpingHappy = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/juegos/Naranjito juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(105, 55, 678, 654),
  );

  /// (1,0) Pensativo con manita en la barbilla ("Pero, Pablito, ¿crees que todos se están divirtiendo cuando alguien termina lastimado?")
  static const naranjitoPensiveHandOnChin = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/juegos/Naranjito juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1094, 52, 522, 704),
    originallyFacesRight: false,
  );

  /// (0,1) Dedito arriba enseñando ("¡Así es! Todos tenemos derecho a jugar tranquilos. Si algo nos lastima o nos hace sentir miedo, podemos decir que no nos gusta y pedir ayuda.")
  static const naranjitoWiseFingerUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/juegos/Naranjito juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(106, 842, 617, 708),
    originallyFacesRight: false,
  );

  /// (1,1) Mano en el corazón escuchando con cariño a Pablito
  static const naranjitoHandOnHeartWarm = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/juegos/Naranjito juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1083, 849, 533, 704),
    originallyFacesRight: false,
  );

  /// (0,2) Pulgar arriba orgulloso ("¡Muy bien, Pablito! Recuerda que un buen amigo no necesita empujar ni lastimar para divertirse.")
  static const naranjitoHappyThumbsUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/juegos/Naranjito juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(164, 1646, 631, 706),
  );

  /// (1,2) Brazos abiertos con gran sonrisa ("¡Los mejores juegos son aquellos en los que todos podemos sonreír!")
  static const naranjitoArmsOpenBigSmile = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/juegos/Naranjito juegos.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(974, 1645, 749, 707),
  );
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/pieza/`
/// for the 7th story ("La pieza perdida del rompecabezas").
class PiezaPoseAtlas {
  PiezaPoseAtlas._();

  // ===========================================================================
  // 1. FLORECITA (`Florecita pieza.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Ambos brazos arriba frustrada ("¡No, ya no sirve de nada todo este trabajo! ¡El rompecabezas está arruinado...!")
  static const florecitaArmsUpFrustratedYelling = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/pieza/Florecita pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(34, 31, 544, 751),
    originallyFacesRight: false,
  );

  /// (1,0) Puños apretados enojada ("¡Porque siento que quiero romper algo y aventarlo lejos!")
  static const florecitaAngryClenchedFists = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/pieza/Florecita pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(658, 30, 511, 748),
    originallyFacesRight: false,
  );

  /// (2,0) Brazos cruzados molesta ("¡No quiero esperar! ¡Quería terminarlo hoy y ahora ya no puedo!")
  static const florecitaArmsCrossedFrowning = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/pieza/Florecita pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1288, 38, 494, 744),
    originallyFacesRight: false,
  );

  /// (0,1) Sosteniendo triste la caja del rompecabezas ("¡Quiero guardar todas las piezas en la caja ahora mismo!")
  static const florecitaSadHoldingPuzzleBox = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/pieza/Florecita pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(60, 827, 496, 754),
    originallyFacesRight: false,
  );

  /// (1,1) Manitas juntas en el pecho con lagrimitas ("Creo que estoy muy triste y enojada porque quería terminarlo hoy para enseñárselo a mi mamá.")
  static const florecitaTearfulHandsClasped = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/pieza/Florecita pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(657, 826, 472, 755),
  );

  /// (2,1) Mano en el pecho sintiendo el nudo enorme y caliente ("sentimos un nudo enorme y caliente en el pecho")
  static const florecitaHandOnChestKnot = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/pieza/Florecita pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1304, 831, 478, 750),
    originallyFacesRight: false,
  );

  /// (0,2) Ojos cerrados y manitas en la pancita respirando profundo ("¡Qué alivio! Creo que ya me siento un poquito más tranquila.")
  static const florecitaDeepBreathingCalm = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/pieza/Florecita pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(43, 1630, 465, 748),
  );

  /// (1,2) Manitas juntas al frente pidiendo perdón ("Tienen razón. Perdón por querer tirar todas las piezas.")
  static const florecitaApologeticHandsClasped = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/pieza/Florecita pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(655, 1631, 471, 747),
  );

  /// (2,2) Puñito arriba animada y feliz ("¡Sí! ¡Y si no encontramos la cabeza del león hoy, podemos seguir buscando mañana!")
  static const florecitaDeterminedHappyFist = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/pieza/Florecita pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1270, 1632, 507, 746),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 2. NARANJITO (`Naranjito pieza.png` - 1792 x 2400, Grid 2x3)
  // ===========================================================================
  /// (0,0) Explicando con empatía ("A veces, cuando las cosas no salen como queremos, sentimos un nudo enorme y caliente en el pecho.")
  static const naranjitoConcernedExplaining = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/pieza/Naranjito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(176, 44, 590, 714),
  );

  /// (1,0) Mano en el corazón con ternura ("Florecita, ¿por qué no intentamos descubrir qué estás sintiendo...?")
  static const naranjitoWarmHandOnHeart = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/pieza/Naranjito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1075, 44, 538, 714),
  );

  /// (0,1) Preguntando con cariño ("¿Estás enojada, triste o tal vez un poquito de las dos?")
  static const naranjitoAskingEmpathetic = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/pieza/Naranjito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(163, 842, 635, 715),
  );

  /// (1,1) Ojos cerrados y manitas en la pancita guiando la respiración ("Toma aire lentamente por la nariz y suéltalo despacito por la boca.")
  static const naranjitoDeepBreathingEyesClosed = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/pieza/Naranjito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1079, 843, 535, 714),
  );

  /// (0,2) Pulgar arriba celebrando
  static const naranjitoHappyThumbsUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/pieza/Naranjito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(177, 1642, 607, 712),
  );

  /// (1,2) Brazos abiertos con gran sonrisa ("¡Así se hace! Recuerden que todas las emociones son importantes...")
  static const naranjitoArmsOpenBigSmile = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/pieza/Naranjito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(982, 1642, 739, 713),
  );

  // ===========================================================================
  // 3. PABLITO (`Pablito pieza.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Ambas manos levantadas pidiendo calma ("¡Espera, Florecita, no tires todo!")
  static const pablitoStopWaitBothHands = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/pieza/Pablito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(80, 9, 428, 782),
  );

  /// (1,0) Agachándose buscando la pieza debajo de la alfombra o la silla
  static const pablitoBendingLookingDown = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/pieza/Pablito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(661, 42, 430, 749),
    originallyFacesRight: false,
  );

  /// (2,0) Señalando con entusiasmo ("¡Mira cuánto hemos avanzado! No tenemos que rendirnos tan rápido.")
  static const pablitoPointingEncouraging = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/pieza/Pablito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1240, 22, 497, 769),
    originallyFacesRight: false,
  );

  /// (0,1) Manitas en el pecho preocupado ("No desarmes lo que ya armamos juntos. ¡Nos costó muchísimo trabajo construir toda esta selva de animales!")
  static const pablitoConcernedHandsChest = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/pieza/Pablito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(81, 810, 396, 778),
  );

  /// (1,1) Levantando el dedito con una gran idea ("¡Yo sé qué podemos hacer! Mi mamá me dice que soy como un globo rojo a punto de explotar...")
  static const pablitoIdeaFingerUp = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/pieza/Pablito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(683, 809, 454, 779),
  );

  /// (2,1) Ojos cerrados y brazos abiertos respirando profundo para desinflar el globo despacito
  static const pablitoDeepBreathingArmsOpen = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/pieza/Pablito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1211, 813, 568, 775),
  );

  /// (0,2) Hablando con calma con una mano abierta ("¿Ves? Está bien estar triste o enojada cuando algo no sale como queremos.")
  static const pablitoSpeakingCalmOpenHand = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/pieza/Pablito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(95, 1612, 498, 777),
  );

  /// (1,2) De pie sonriendo con ternura y comprensión
  static const pablitoWarmStandingSmile = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/pieza/Pablito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(687, 1612, 399, 776),
  );

  /// (2,2) Señalando hacia el sillón azul ("¿Qué tal si recogemos las piezas y buscamos juntos debajo del sillón azul?")
  static const pablitoPointingToBlueSofa = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/pieza/Pablito pieza.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1279, 1611, 469, 777),
  );
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/carrito/`
/// for the 8th story ("El carrito rojo de bomberos").
class CarritoPoseAtlas {
  CarritoPoseAtlas._();

  // ===========================================================================
  // 1. FLORECITA (`Florecita carrito.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Sosteniendo feliz el carrito rojo en su mano
  static const florecitaHoldingCarHappy = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/carrito/Florecita carrito.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(41, 26, 676, 809),
  );

  /// (1,0) Abrazando el carrito rojo sorprendida cuando Pablito intenta quitárselo
  static const florecitaHuggingCarProtective = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/carrito/Florecita carrito.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1198, 35, 568, 811),
    originallyFacesRight: false,
  );

  /// (0,1) Levantando la mano pidiendo esperar ("¡Espera, Pablito! Todavía no termino de llevar a los pasajeros a la estación.")
  static const florecitaStopWaitHand = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/carrito/Florecita carrito.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(91, 845, 523, 743),
  );

  /// (1,1) Manos en la cintura molesta porque Pablito jala el carrito
  static const florecitaHandsOnHipsFrowning = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/carrito/Florecita carrito.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(678, 843, 524, 746),
  );

  /// (0,2) De pie escuchando con atención a Naranjito y a Pablito
  static const florecitaStandingListening = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/carrito/Florecita carrito.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(72, 1604, 551, 755),
    originallyFacesRight: false,
  );

  /// (1,2) Señalando sonriente hacia la estación de bomberos ("¡Sí, claro! Cuando el camión llegue a la estación de bomberos...")
  static const florecitaPointingStationSmiling = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/carrito/Florecita carrito.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(638, 1603, 532, 757),
  );

  /// (2,2) Entregando el carrito rojo con cariño a Pablito ("...te lo doy para que tú seas el nuevo chofer.")
  static const florecitaSharingCarBothHands = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/carrito/Florecita carrito.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1175, 1602, 602, 754),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 2. NARANJITO (`Naranjito carrito.png` - 1856 x 2304, Grid 2x3)
  // ===========================================================================
  /// (0,0) Levantando la manita ("¡Pablito, detente un momento!")
  static const naranjitoStopWaitHand = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/carrito/Naranjito carrito.png',
    sheetWidth: 1856,
    sheetHeight: 2304,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(141, 82, 614, 700),
  );

  /// (1,0) Señalando con ambos deditos ("Mira tus manos, estás jalando el carrito con mucha fuerza.")
  static const naranjitoPointingFingersTogether = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/carrito/Naranjito carrito.png',
    sheetWidth: 1856,
    sheetHeight: 2304,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1188, 80, 529, 701),
  );

  /// (0,1) Preguntando con una mano abierta ("¿Qué tal si usamos nuestras palabras en lugar de nuestras manos para pedir lo que queremos?")
  static const naranjitoAskingOneHandOpen = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/carrito/Naranjito carrito.png',
    sheetWidth: 1856,
    sheetHeight: 2304,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(138, 824, 644, 700),
  );

  /// (1,1) Mostrando sus dos manitas abiertas ("Recuerda que nuestras manos son maravillosas para saludar, abrazar, construir y ayudar.")
  static const naranjitoShowingBothHandsOpen = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/carrito/Naranjito carrito.png',
    sheetWidth: 1856,
    sheetHeight: 2304,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1176, 822, 565, 700),
  );

  /// (0,2) Pulgar arriba celebrando ("¡Muy bien, Pablito!")
  static const naranjitoHappyThumbsUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/carrito/Naranjito carrito.png',
    sheetWidth: 1856,
    sheetHeight: 2304,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(140, 1559, 623, 676),
  );

  /// (1,2) Brazos abiertos con gran sonrisa ("¡Recuerden que cada quien tiene su turno!")
  static const naranjitoArmsOpenBigSmile = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/carrito/Naranjito carrito.png',
    sheetWidth: 1856,
    sheetHeight: 2304,
    cols: 2,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1068, 1560, 740, 675),
  );

  // ===========================================================================
  // 3. PABLITO (`Pablito carrito.png` - 1536 x 2730, Grid 3x3)
  // ===========================================================================
  /// (0,0) Estirando ambas manos para arrebatar el carrito ("¡Yo quiero el carrito rojo ahora mismo! ¡Dámelo!")
  static const pablitoReachingGrabbingCar = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/carrito/Pablito carrito.png',
    sheetWidth: 1536,
    sheetHeight: 2730,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(26, 20, 545, 888),
  );

  /// (1,0) Puño cerrado impaciente y enojado ("¡No quiero esperar! ¡Dámelo! ¡Es mi carrito favorito de todo el salón!")
  static const pablitoAngryClenchedFist = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/carrito/Pablito carrito.png',
    sheetWidth: 1536,
    sheetHeight: 2730,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(571, 21, 468, 881),
  );

  /// (2,0) Mirando sus dos manos abiertas reflexionando ("Mira tus manos, estás jalando el carrito con mucha fuerza.")
  static const pablitoLookingAtHands = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/carrito/Pablito carrito.png',
    sheetWidth: 1536,
    sheetHeight: 2730,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1100, 20, 419, 887),
    originallyFacesRight: false,
  );

  /// (0,1) Mano detrás de la cabeza apenado ("Tienes razón, Naranjito. Me equivoqué. Perdón por jalarlo tan fuerte, Florecita.")
  static const pablitoApologeticHandBehindHead = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/carrito/Pablito carrito.png',
    sheetWidth: 1536,
    sheetHeight: 2730,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(23, 920, 452, 921),
  );

  /// (1,1) Manitas juntas pidiendo por favor con sonrisa amable ("¿Por favor, me prestas el carrito cuando termines de dar esa vuelta por la ciudad?")
  static const pablitoPleaseHandsTogether = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/carrito/Pablito carrito.png',
    sheetWidth: 1536,
    sheetHeight: 2730,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(556, 919, 453, 922),
  );

  /// (2,1) Manos atrás esperando su turno con paciencia y alegría
  static const pablitoWaitingPatientlyHandsBack = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/carrito/Pablito carrito.png',
    sheetWidth: 1536,
    sheetHeight: 2730,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1075, 925, 427, 916),
  );

  /// (0,2) Arrodillado acomodando bloquecitos en la pista ("¡Muchas gracias! Mientras espero, puedo preparar la pista para nuestra siguiente emergencia.")
  static const pablitoKneelingBuildingTrack = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/carrito/Pablito carrito.png',
    sheetWidth: 1536,
    sheetHeight: 2730,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(14, 1996, 530, 734),
  );

  /// (1,2) Pulgar arriba feliz
  static const pablitoHappyThumbsUp = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/carrito/Pablito carrito.png',
    sheetWidth: 1536,
    sheetHeight: 2730,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(579, 1864, 432, 866),
    originallyFacesRight: false,
  );

  /// (2,2) Señalando entusiasmado la pista de bomberos
  static const pablitoPointingTrackExcited = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/carrito/Pablito carrito.png',
    sheetWidth: 1536,
    sheetHeight: 2730,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1030, 1881, 497, 849),
  );
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/cosquillas/`
/// for the 9th story ("El monstruo de las cosquillas").
class CosquillasPoseAtlas {
  CosquillasPoseAtlas._();

  // ===========================================================================
  // 1. COMPAÑERO (`Companero cosquillas.png` - 2752 x 1536, Top row 3 poses, Bottom row 5 poses)
  // ===========================================================================
  /// (0,0) Manos levantadas haciendo cosquillas ("¡Cosquillas, cosquillas del gran monstruo come-niños!")
  static const companeroTickleHandsUp = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/cosquillas/Companero cosquillas.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 3,
    rows: 2,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(160, 38, 458, 729),
  );

  /// (1,0) Agachado como monstruo de las cosquillas ("¡Aquí viene el monstruo de las cosquillas! ¡Prepárate, Florecita, que allá voy!")
  static const companeroTickleMonsterCrouch = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/cosquillas/Companero cosquillas.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 3,
    rows: 2,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1227, 51, 359, 717),
  );

  /// (2,0) Encogiéndose de hombros con las manos abiertas ("¡Pero yo solo quería hacerla reír! ¡No pensé que se molestaría tanto!")
  static const companeroShruggingBothHands = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/cosquillas/Companero cosquillas.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 3,
    rows: 2,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(2124, 45, 498, 722),
    originallyFacesRight: false,
  );

  /// (0,1) Mirando hacia abajo apenado con las manos juntas ("Oh... perdón, Florecita. De verdad creí que estábamos jugando...")
  static const companeroApologeticLookingDown = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/cosquillas/Companero cosquillas.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 5,
    rows: 2,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(217, 793, 313, 709),
    originallyFacesRight: false,
  );

  /// (1,1) Mano en la barbilla reflexionando sobre lo que le dice Florecita
  static const companeroThinkingChin = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/cosquillas/Companero cosquillas.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 5,
    rows: 2,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(732, 784, 296, 718),
  );

  /// (2,1) Mano en el pecho prometiendo con respeto ("Tienes razón. Te prometo que no volveré a hacerte cosquillas si no quieres.")
  static const companeroHandOnHeartPromise = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/cosquillas/Companero cosquillas.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 5,
    rows: 2,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1259, 783, 323, 719),
    originallyFacesRight: false,
  );

  /// (3,1) De pie con las manos atrás sonriendo respetuosamente
  static const companeroStandingPoliteHandsBack = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/cosquillas/Companero cosquillas.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 5,
    rows: 2,
    col: 3,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1751, 784, 322, 718),
    originallyFacesRight: false,
  );

  /// (4,1) Invitando con la mano abierta ("¿Podemos seguir jugando a otra cosa?")
  static const companeroInvitingOpenHand = CharacterPoseSpec(
    characterId: 'companero',
    sheetFileName: 'movimientos/cosquillas/Companero cosquillas.png',
    sheetWidth: 2752,
    sheetHeight: 1536,
    cols: 5,
    rows: 2,
    col: 4,
    row: 1,
    tightPixelRect: Rect.fromLTWH(2176, 782, 389, 720),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 2. FLORECITA (`Florecita cosquillas.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Sentada sosteniendo su sándwich tranquila
  static const florecitaSittingWithSandwich = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/cosquillas/Florecita cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(79, 31, 521, 754),
    originallyFacesRight: false,
  );

  /// (1,0) Riendo incómoda con las manos levantadas ("¡Ay, me da mucha risa, pero ya basta! ¡No quiero más cosquillas! ¡Déjame tranquila!")
  static const florecitaLaughingUncomfortableStop = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/cosquillas/Florecita cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(676, 32, 517, 757),
    originallyFacesRight: false,
  );

  /// (2,0) Levantando la palma firme diciendo "¡Basta / Alto!"
  static const florecitaStopHandFirm = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/cosquillas/Florecita cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1261, 31, 507, 757),
  );

  /// (0,1) Manos en la cintura hablando fuerte y claro ("¡Basta! ¡Escúchame bien! No me gusta que me hagas cosquillas. ¡Me molesta muchísimo que me toques así sin preguntarme!")
  static const florecitaAngryHandsOnHips = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/cosquillas/Florecita cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(78, 818, 508, 758),
    originallyFacesRight: false,
  );

  /// (1,1) Dedito en la barbilla escuchando el consejo de Naranjito
  static const florecitaThinkingChin = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/cosquillas/Florecita cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(683, 817, 511, 758),
    originallyFacesRight: false,
  );

  /// (2,1) Mano en el pecho con seguridad ("tu cuerpo es tuyo y nadie debe tocarte si tú no quieres")
  static const florecitaConfidentHandOnChest = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/cosquillas/Florecita cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1263, 819, 515, 757),
    originallyFacesRight: false,
  );

  /// (0,2) Explicando con ambas manos ("Está bien que quieras jugar conmigo, pero primero debes preguntarme si quiero. ¡No todos disfrutamos de los mismos juegos!")
  static const florecitaExplainingBothHands = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/cosquillas/Florecita cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(68, 1612, 516, 766),
  );

  /// (1,2) Sentada comiendo feliz su sándwich ("¡Claro! Pero primero quiero terminar mi sándwich.")
  static const florecitaEatingSandwichHappy = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/cosquillas/Florecita cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(674, 1613, 527, 760),
    originallyFacesRight: false,
  );

  /// (2,2) Señalando sonriente hacia los juegos del patio ("Después podemos jugar juntos en el patio.")
  static const florecitaPointingPatioSmiling = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/cosquillas/Florecita cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1235, 1615, 552, 763),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 3. NARANJITO (`Naranjito cosquillas.png` - 1792 x 2400, Grid 2x3)
  // ===========================================================================
  /// (0,0) Mano en el corazón hablando con ternura ("Recuerda algo muy importante, Florecita: tu cuerpo es tuyo y nadie debe tocarte si tú no quieres.")
  static const naranjitoWarmHandOnHeart = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/cosquillas/Naranjito cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(179, 37, 539, 720),
  );

  /// (1,0) Levantando el dedito firme ("Aunque alguien diga que solo está jugando, tienes derecho a decir que no.")
  static const naranjitoFirmFingerUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/cosquillas/Naranjito cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1020, 37, 621, 720),
    originallyFacesRight: false,
  );

  /// (0,1) Manitas alrededor de la boca ("¿Recuerdas que tienes una voz fuerte y valiente para decir qué te gusta y qué te incomoda?")
  static const naranjitoVoiceCuppedHands = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/cosquillas/Naranjito cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(178, 834, 540, 719),
  );

  /// (1,1) Levantando la palma firme diciendo "¡No / Alto!"
  static const naranjitoStopHandFirm = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/cosquillas/Naranjito cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1051, 836, 588, 717),
    originallyFacesRight: false,
  );

  /// (0,2) Pulgar arriba orgulloso ("¡Muy bien, Florecita! Decir lo que no nos gusta es importante.")
  static const naranjitoHappyThumbsUp = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/cosquillas/Naranjito cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(161, 1635, 563, 712),
    originallyFacesRight: false,
  );

  /// (1,2) Brazos abiertos con gran sonrisa ("¡Súper! Recuerden: su cuerpo les pertenece, pueden decir NO cuando algo les incomoda...")
  static const naranjitoArmsOpenBigSmile = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/cosquillas/Naranjito cosquillas.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 2,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(974, 1635, 752, 712),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 4. PABLITO (`Pablito cosquillas.png` - 1696 x 2528, Grid 2x3)
  // ===========================================================================
  /// (0,0) Levantando la mano ("¡Oye, espera! Déjala comer su sándwich tranquila.")
  static const pablitoStopWaitHand = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/cosquillas/Pablito cosquillas.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(213, 9, 430, 809),
  );

  /// (1,0) Señalando a Florecita preocupado ("¡Mira su carita! No parece que se esté divirtiendo con tus cosquillas.")
  static const pablitoPointingAtFlorecitaFace = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/cosquillas/Pablito cosquillas.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1039, 13, 492, 808),
  );

  /// (0,1) Brazos cruzados serio apoyando a Florecita
  static const pablitoArmsCrossedSerious = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/cosquillas/Pablito cosquillas.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(213, 858, 385, 807),
  );

  /// (1,1) Manos atrás escuchando con atención
  static const pablitoListeningHandsBack = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/cosquillas/Pablito cosquillas.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1067, 861, 383, 804),
  );

  /// (0,2) Levantando la mano contento ("¡Y esta vez podemos elegir un juego que nos guste a todos!")
  static const pablitoWavingHappy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/cosquillas/Pablito cosquillas.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(200, 1704, 494, 811),
  );

  /// (1,2) Saltando de alegría con ambos brazos arriba
  static const pablitoJumpingJoy = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/cosquillas/Pablito cosquillas.png',
    sheetWidth: 1696,
    sheetHeight: 2528,
    cols: 2,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1034, 1709, 498, 756),
  );
}

/// Complete catalog of analyzed poses from `assets/images/movimientos/parque/`
/// for the 10th story ("El desconocido en el parque").
class ParquePoseAtlas {
  ParquePoseAtlas._();

  // ===========================================================================
  // 1. SEÑOR DESCONOCIDO (`senor desconocido parque.png` - 2400 x 1792, Grid 3x2)
  // ===========================================================================
  /// (0,0) Saludando con la mano levantada ("¡Hola, amiguito! Veo que estás jugando muy divertido.")
  static const desconocidoWavingHello = CharacterPoseSpec(
    characterId: 'desconocido',
    sheetFileName: 'movimientos/parque/senor desconocido parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(171, 42, 391, 836),
  );

  /// (1,0) Sosteniendo una barra de chocolate ("Tengo unos juguetes nuevos increíbles y unos dulces de chocolate muy ricos. ¿Te gustan los dulces?")
  static const desconocidoOfferingChocolate = CharacterPoseSpec(
    characterId: 'desconocido',
    sheetFileName: 'movimientos/parque/senor desconocido parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(998, 42, 371, 836),
  );

  /// (2,0) Mano en el pecho e invitando ("¡Qué bien! Pues tengo muchos regalos para ti...")
  static const desconocidoInvitingHandOnChest = CharacterPoseSpec(
    characterId: 'desconocido',
    sheetFileName: 'movimientos/parque/senor desconocido parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1869, 44, 426, 834),
  );

  /// (0,1) Señalando hacia su coche detrás de los árboles ("...pero los dejé guardados en mi coche, allá atrás de aquellos árboles. ¿Quieres venir conmigo rapidito?")
  static const desconocidoPointingToCarBehindTrees = CharacterPoseSpec(
    characterId: 'desconocido',
    sheetFileName: 'movimientos/parque/senor desconocido parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(229, 943, 470, 831),
  );

  /// (1,1) Insistiendo con la mano abierta ("¡Vamos, amiguito! No tengas miedo. Solo será un momentito y después podrás regresar a jugar.")
  static const desconocidoInsistingComeQuickly = CharacterPoseSpec(
    characterId: 'desconocido',
    sheetFileName: 'movimientos/parque/senor desconocido parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1042, 933, 441, 842),
  );

  /// (2,1) Brazos abajo desconcertado cuando Pablito dice que no y se va con su mamá
  static const desconocidoFoiledDisappointed = CharacterPoseSpec(
    characterId: 'desconocido',
    sheetFileName: 'movimientos/parque/senor desconocido parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1862, 933, 324, 842),
  );

  // ===========================================================================
  // 2. PABLITO (`Pablito parque.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) De rodillas jugando contento con sus carritos rojos en el pasto
  static const pablitoPlayingWithToyCars = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/parque/Pablito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(34, 50, 530, 681),
  );

  /// (1,0) De pie escuchando sorprendido al señor desconocido
  static const pablitoSurprisedListening = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/parque/Pablito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(693, 7, 397, 778),
  );

  /// (2,0) Emocionado con las manos junto a las mejillas ("¡Sí! ¡Me encantan los chocolates y los carritos de juguete!")
  static const pablitoExcitedHandsByCheeks = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/parque/Pablito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1291, 8, 379, 777),
  );

  /// (0,1) Pensativo con el dedito en la barbilla dudando ("¿De verdad? ¡Qué bonitos regalos! Pero... ¿por qué están tan lejos?")
  static const pablitoDoubtfulHandOnChin = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/parque/Pablito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(94, 801, 382, 788),
  );

  /// (1,1) Preocupado abrazándose los brazos ("No, no lo conozco en absoluto. Nunca lo había visto en este parque.")
  static const pablitoWorriedArmsCrossed = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/parque/Pablito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(706, 802, 354, 788),
  );

  /// (2,1) Levantando la palma diciendo "¡Alto / No!" con firmeza ("¡No, muchas gracias! Mi mamá me enseñó que no debo irme con personas desconocidas ni aceptar regalos sin preguntarle primero.")
  static const pablitoStopHandFirmNo = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/parque/Pablito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1274, 804, 404, 785),
    originallyFacesRight: false,
  );

  /// (0,2) Brazos cruzados firme y seguro
  static const pablitoFirmArmsCrossed = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/parque/Pablito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(95, 1605, 376, 783),
    originallyFacesRight: false,
  );

  /// (1,2) Corriendo hacia su mamá y Florecita ("¡Ya voy, Florecita! ¡No quiero sus regalos, tengo que ir con mi mamá!")
  static const pablitoRunningToMom = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/parque/Pablito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(684, 1610, 448, 776),
  );

  /// (2,2) Contándole todo a su mamá con confianza ("¡Se lo voy a contar todo! ¡Así mi mamá podrá ayudarme!")
  static const pablitoTellingMomEverything = CharacterPoseSpec(
    characterId: 'pablito',
    sheetFileName: 'movimientos/parque/Pablito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1289, 1607, 479, 784),
  );

  // ===========================================================================
  // 3. NARANJITO (`Naranjito parque.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Levantando la mano pidiendo detenerse ("¡Un momento, Pablito! No des ni un paso más.")
  static const naranjitoStopHandWait = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/parque/Naranjito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(52, 51, 475, 557),
    originallyFacesRight: false,
  );

  /// (1,0) Expresión preocupada advirtiendo del peligro
  static const naranjitoWorriedWarning = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/parque/Naranjito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(692, 50, 406, 559),
  );

  /// (2,0) Manita en la barbilla preguntando ("¿Conoces a esta persona? ¿Sabes quién es y por qué quiere llevarte a un lugar donde no hay nadie?")
  static const naranjitoThinkingQuestion = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/parque/Naranjito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1282, 49, 418, 559),
    originallyFacesRight: false,
  );

  /// (0,1) Dedito índice arriba advirtiendo con firmeza ("Entonces debes tener mucho cuidado. Nunca te alejes con alguien que no sea de confianza...")
  static const naranjitoWiseFingerUpWarning = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/parque/Naranjito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(86, 897, 506, 563),
  );

  /// (1,1) Hablando con cariño con las manos abiertas ("¡Muy bien, Pablito! Ahora ve con tu mamá y cuéntale lo que acaba de pasar...")
  static const naranjitoSpeakingGentleHands = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/parque/Naranjito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(681, 898, 485, 565),
  );

  /// (2,1) Mano en el corazón escuchando con cariño
  static const naranjitoHandOnHeartCaring = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/parque/Naranjito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1281, 897, 425, 564),
  );

  /// (0,2) Señalando con seriedad ("¡Tampoco tienes que aceptar nada para quedar bien con esa persona!")
  static const naranjitoPointingWarning = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/parque/Naranjito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(84, 1789, 512, 550),
  );

  /// (1,2) Pulgar arriba orgulloso de Pablito
  static const naranjitoThumbsUpProud = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/parque/Naranjito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(681, 1790, 493, 548),
  );

  /// (2,2) Brazos abiertos con gran sonrisa ("¡Recuerden, pequeños! Nunca se vayan con desconocidos ni acepten regalos sin consultar primero con un adulto de confianza. ¡Su seguridad siempre es lo más importante!")
  static const naranjitoArmsOpenBigSmile = CharacterPoseSpec(
    characterId: 'naranjito',
    sheetFileName: 'movimientos/parque/Naranjito parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1209, 1789, 575, 549),
  );

  // ===========================================================================
  // 4. FLORECITA (`Florecita parque.png` - 1792 x 2400, Grid 3x3)
  // ===========================================================================
  /// (0,0) Manos junto a la boca llamando a Pablito ("¡Pablito! ¡Ven rápido! ¡Tu mamá nos está llamando desde la mesa de madera para tomar agua de limón!")
  static const florecitaCallingHandsCupped = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/parque/Florecita parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(48, 26, 475, 760),
  );

  /// (1,0) Saludando con brazo en alto llamando a Pablito
  static const florecitaWavingComeHere = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/parque/Florecita parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(652, 26, 520, 757),
  );

  /// (2,0) Haciendo gesto de venir con una sonrisa
  static const florecitaBeckoningSmiling = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/parque/Florecita parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1269, 33, 516, 748),
    originallyFacesRight: false,
  );

  /// (0,1) Sosteniendo su vaso de agua de limón fresca
  static const florecitaHoldingLemonadeGlass = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/parque/Florecita parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(57, 822, 502, 763),
    originallyFacesRight: false,
  );

  /// (1,1) Saludando contenta
  static const florecitaFriendlyWave = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/parque/Florecita parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(669, 822, 496, 763),
  );

  /// (2,1) Llamando con la mano derecha arriba
  static const florecitaCallingHandUp = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/parque/Florecita parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1245, 827, 541, 758),
    originallyFacesRight: false,
  );

  /// (0,2) Invitando con la mano extendida hacia la mamá de Pablito
  static const florecitaPointingToMom = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/parque/Florecita parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 0,
    row: 2,
    tightPixelRect: Rect.fromLTWH(39, 1626, 528, 756),
  );

  /// (1,2) Escuchando tranquila
  static const florecitaCalmListening = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/parque/Florecita parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 1,
    row: 2,
    tightPixelRect: Rect.fromLTWH(666, 1626, 508, 756),
    originallyFacesRight: false,
  );

  /// (2,2) Manos juntas en el pecho muy feliz de que Pablito esté seguro
  static const florecitaHappyHandsTogether = CharacterPoseSpec(
    characterId: 'florecita',
    sheetFileName: 'movimientos/parque/Florecita parque.png',
    sheetWidth: 1792,
    sheetHeight: 2400,
    cols: 3,
    rows: 3,
    col: 2,
    row: 2,
    tightPixelRect: Rect.fromLTWH(1269, 1624, 507, 758),
    originallyFacesRight: false,
  );

  // ===========================================================================
  // 5. MAMÁ DE PABLITO (`mama pablito parque.png` - 2400 x 1792, Grid 3x2)
  // ===========================================================================
  /// (0,0) Saludando cariñosamente con la mano
  static const mamaWavingHello = CharacterPoseSpec(
    characterId: 'mama',
    sheetFileName: 'movimientos/parque/mama pablito parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 0,
    row: 0,
    tightPixelRect: Rect.fromLTWH(156, 45, 444, 853),
    originallyFacesRight: false,
  );

  /// (1,0) Manos junto a la boca llamando a Pablito y Florecita
  static const mamaCallingHandsCupped = CharacterPoseSpec(
    characterId: 'mama',
    sheetFileName: 'movimientos/parque/mama pablito parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 1,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1030, 48, 356, 851),
  );

  /// (2,0) Sosteniendo la jarra de agua de limón y un vaso
  static const mamaHoldingLemonadePitcher = CharacterPoseSpec(
    characterId: 'mama',
    sheetFileName: 'movimientos/parque/mama pablito parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 2,
    row: 0,
    tightPixelRect: Rect.fromLTWH(1787, 48, 416, 851),
  );

  /// (0,1) Inclinándose con las manos en las rodillas para escuchar con ternura a Pablito
  static const mamaLeaningListeningCaring = CharacterPoseSpec(
    characterId: 'mama',
    sheetFileName: 'movimientos/parque/mama pablito parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 0,
    row: 1,
    tightPixelRect: Rect.fromLTWH(246, 925, 369, 854),
  );

  /// (1,1) Mano en el pecho preocupada y atenta mientras Pablito le cuenta lo que pasó
  static const mamaConcernedHandOnHeart = CharacterPoseSpec(
    characterId: 'mama',
    sheetFileName: 'movimientos/parque/mama pablito parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 1,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1019, 923, 372, 855),
    originallyFacesRight: false,
  );

  /// (2,1) Brazos abiertos lista para abrazar y proteger a Pablito
  static const mamaOpenArmsProtectiveHug = CharacterPoseSpec(
    characterId: 'mama',
    sheetFileName: 'movimientos/parque/mama pablito parque.png',
    sheetWidth: 2400,
    sheetHeight: 1792,
    cols: 3,
    rows: 2,
    col: 2,
    row: 1,
    tightPixelRect: Rect.fromLTWH(1686, 924, 649, 855),
  );
}

/// A Flutter Widget that renders a single cropped pose from a character collage sheet
class CharacterPoseWidget extends StatelessWidget {
  final CharacterPoseSpec pose;
  final double? height;
  final double? width;

  const CharacterPoseWidget({
    super.key,
    required this.pose,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final rect = pose.tightPixelRect;
    final alignX = (2 * rect.center.dx - pose.sheetWidth) /
        (pose.sheetWidth - rect.width);
    final alignY = (2 * rect.center.dy - pose.sheetHeight) /
        (pose.sheetHeight - rect.height);

    Widget content = AspectRatio(
      aspectRatio: pose.aspectRatio,
      child: ClipRect(
        child: FractionallySizedBox(
          widthFactor: pose.sheetWidth / rect.width,
          heightFactor: pose.sheetHeight / rect.height,
          alignment: Alignment(alignX, alignY),
          child: Image.asset(
            pose.assetPath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );

    if (height != null || width != null) {
      return SizedBox(
        height: height,
        width: width,
        child: Center(child: content),
      );
    }
    return content;
  }
}

class VoiceBeat {
  final String speakerId; // 'narrador', 'companero', 'florecita', 'naranjito', 'pablito', 'maestra'
  final String text; // Spoken dialogue or intro action narration (never stage metadata)
  final double pitch;
  final double rate;
  final Map<String, CharacterPoseSpec> poseChanges;
  final Map<String, Offset> positionChanges;

  const VoiceBeat({
    required this.speakerId,
    required this.text,
    this.pitch = 1.15,
    this.rate = 0.45,
    this.poseChanges = const {},
    this.positionChanges = const {},
  });
}

class CharacterPlacement {
  final String characterId;
  final CharacterPoseSpec initialPose;
  final Offset normalizedPosition; // 0.0 to 1.0 relative to canvas
  final double scale;
  final String initialEmotion;
  final String spokenPhrase;
  final double voicePitch;

  const CharacterPlacement({
    required this.characterId,
    required this.initialPose,
    required this.normalizedPosition,
    this.scale = 1.0,
    this.initialEmotion = 'bounce',
    required this.spokenPhrase,
    this.voicePitch = 1.2,
  });
}

class InteractivePropData {
  final String type; // 'broken_crayon', 'paper_dinosaur', 'heart', 'star'
  final Offset normalizedPosition;
  final String spokenSound;

  const InteractivePropData({
    required this.type,
    required this.normalizedPosition,
    required this.spokenSound,
  });
}

class StorySceneData {
  final int index;
  final String backgroundAsset;
  final List<VoiceBeat> beats;
  final List<CharacterPlacement> characters;
  final List<InteractivePropData> props;

  const StorySceneData({
    required this.index,
    required this.backgroundAsset,
    required this.beats,
    required this.characters,
    this.props = const [],
  });
}

const List<StorySceneData> crayonStoryScenes = [
  // ===========================================================================
  // ESCENA 1 (Fondo 1: Salón de clases - Crayon2.jpg)
  // Intro visual + Compañero rompe el crayón rojo y amenaza a Florecita
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Crayon/Crayon2.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'companero',
        initialPose: CrayonPoseAtlas.companeroHoldingBrokenCrayon,
        normalizedPosition: Offset(0.32, 0.65),
        scale: 1.0,
        initialEmotion: 'whisper',
        spokenPhrase:
            'Es un secreto, Florecita. Nadie puede saber que rompí el crayón rojo.',
        voicePitch: 0.96,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CrayonPoseAtlas.florecitaShockedHandChest,
        normalizedPosition: Offset(0.68, 0.66),
        scale: 0.96,
        initialEmotion: 'sad',
        spokenPhrase: '¡Oh no! Rompió el crayón rojo nuevo a la mitad.',
        voicePitch: 1.28,
      ),
    ],
    beats: [
      // Intro visual/narrado (sin leer la palabra "Intro" ni "Fondo 1")
      VoiceBeat(
        speakerId: 'narrador',
        text: 'El crayón rojo. Un niño rompe un crayón rojo, y Florecita lo vio todo.',
        pitch: 1.12,
        rate: 0.45,
        poseChanges: {
          'companero': CrayonPoseAtlas.companeroHoldingBrokenCrayon,
          'florecita': CrayonPoseAtlas.florecitaShockedHandChest,
        },
      ),
      // Diálogo Compañero 1
      VoiceBeat(
        speakerId: 'companero',
        text:
            'Es un secreto, Florecita. Nadie en la escuela puede saber que yo rompí este crayón rojo nuevo a la mitad.',
        pitch: 0.96,
        rate: 0.44,
        poseChanges: {
          'companero': CrayonPoseAtlas.companeroShushingSecret,
          'florecita': CrayonPoseAtlas.florecitaShockedHandChest,
        },
      ),
      // Diálogo Compañero 2
      VoiceBeat(
        speakerId: 'companero',
        text:
            'Si vas y le dices a la maestra, ya no voy a jugar contigo nunca más en el recreo, ni te prestaré mis juguetes.',
        pitch: 0.95,
        rate: 0.44,
        poseChanges: {
          'companero': CrayonPoseAtlas.companeroArmsCrossed,
          'florecita': CrayonPoseAtlas.florecitaWorriedHandsClasped,
        },
      ),
      // Diálogo Compañero 3
      VoiceBeat(
        speakerId: 'companero',
        text:
            'Y además, les diré a todos los niños del salón que fuiste tú quien lo rompió. Tienes que prometerme que no dirás nada y que lo esconderemos para siempre.',
        pitch: 0.94,
        rate: 0.44,
        poseChanges: {
          'companero': CrayonPoseAtlas.companeroPointingBlaming,
          'florecita': CrayonPoseAtlas.florecitaSadLookingDown,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'broken_crayon',
        normalizedPosition: Offset(0.50, 0.78),
        spokenSound: '¡El crayón rojo nuevo se rompió a la mitad!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2 (Fondo 1: Salón de clases - Crayon2.jpg)
  // Naranjito habla con Florecita sobre los secretos divertidos vs los que asustan
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Crayon/Crayon2.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CrayonPoseAtlas.naranjitoEmpatheticAsking,
        normalizedPosition: Offset(0.30, 0.56),
        scale: 0.72,
        initialEmotion: 'appear',
        spokenPhrase:
            '¿Los secretos de verdad te hacen sentir así de preocupada y triste?',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CrayonPoseAtlas.florecitaSittingSadBrush,
        normalizedPosition: Offset(0.64, 0.67),
        scale: 0.96,
        initialEmotion: 'sad',
        spokenPhrase:
            'Este secreto no es nada divertido, siento como si cargara una piedra muy pesada.',
        voicePitch: 1.28,
      ),
    ],
    beats: [
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Florecita... escúchame un momento. ¿Los secretos de verdad te hacen sentir así de preocupada y triste?',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': CrayonPoseAtlas.naranjitoEmpatheticAsking,
          'florecita': CrayonPoseAtlas.florecitaWorriedHandsClasped,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¿Te quitan las ganas de terminar de dibujar tu flor y de jugar con tus amigos?',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': CrayonPoseAtlas.naranjitoGentleQuestion,
          'florecita': CrayonPoseAtlas.florecitaSittingSadBrush,
        },
      ),
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'No, Naranjito. Los secretos divertidos son como cuando hacemos un dibujo sorpresa para el Día de las Madres y no queremos que ella lo vea antes de tiempo. O como cuando escondemos un regalo de cumpleaños.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CrayonPoseAtlas.florecitaSmilingOpenHands,
          'naranjito': CrayonPoseAtlas.naranjitoGentleQuestion,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Este secreto que me acaban de decir no es nada divertido. Me hace sentir asustada. Siento como si cargara una piedra muy pesada, y la verdad es que no me gusta nada tenerlo escondido.',
        pitch: 1.26,
        rate: 0.44,
        poseChanges: {
          'florecita': CrayonPoseAtlas.florecitaShockedHandChest,
          'naranjito': CrayonPoseAtlas.naranjitoEmpatheticAsking,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'broken_crayon',
        normalizedPosition: Offset(0.22, 0.78),
        spokenSound: 'Los secretos que dan susto pesan como una piedra.',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3 (Fondo 1: Salón de clases - Crayon2.jpg)
  // Pablito llega con su dinosaurio de papel, Naranjito aconseja y deciden ir con la maestra
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Crayon/Crayon2.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CrayonPoseAtlas.pablitoShowingDinosaur,
        normalizedPosition: Offset(0.24, 0.65),
        scale: 0.96,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Mira mi dinosaurio con manchas azules! Los amigos siempre se acompañan.',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CrayonPoseAtlas.florecitaSittingSadBrush,
        normalizedPosition: Offset(0.52, 0.66),
        scale: 0.95,
        initialEmotion: 'sad',
        spokenPhrase: '¡Tienes razón, Naranjito! Vamos ahora mismo con la maestra.',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CrayonPoseAtlas.naranjitoEmpatheticAsking,
        normalizedPosition: Offset(0.79, 0.56),
        scale: 0.68,
        initialEmotion: 'bounce',
        spokenPhrase:
            '¡Siempre está bien hablar con un adulto en quien confíes!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Pablito 1
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Mira, Florecita, le pinté unas manchas azules muy grandes a mi dinosaurio de papel. Oye, ¿por qué ya no estás pintando tu flor roja?',
        pitch: 1.15,
        rate: 0.45,
        poseChanges: {
          'pablito': CrayonPoseAtlas.pablitoShowingDinosaur,
          'florecita': CrayonPoseAtlas.florecitaSittingSadBrush,
        },
      ),
      // Diálogo Pablito 2
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Estás muy callada y tú siempre cantas canciones cuando estamos en la clase de arte. ¿Pasa algo malo contigo? ¿Estás cansada?',
        pitch: 1.14,
        rate: 0.45,
        poseChanges: {
          'pablito': CrayonPoseAtlas.pablitoConcerned,
          'florecita': CrayonPoseAtlas.florecitaSadLookingDown,
        },
      ),
      // Diálogo Florecita
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Es que me dieron un secreto que no quiero guardar, Pablito. Me pesa mucho y me pone muy triste. Pero me dijeron que si hablo, ya no van a ser mis amigos y me van a echar la culpa.',
        pitch: 1.26,
        rate: 0.44,
        poseChanges: {
          'florecita': CrayonPoseAtlas.florecitaWorriedHandsClasped,
          'pablito': CrayonPoseAtlas.pablitoListeningCalm,
        },
      ),
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Florecita, las cosas que nos asustan, nos lastiman o nos preocupan nunca, pero nunca, deben ser secretos obligados.',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': CrayonPoseAtlas.naranjitoImportantAdvice,
          'florecita': CrayonPoseAtlas.florecitaThinkingChin,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Los verdaderos amigos no te amenazan ni te obligan a guardar cosas que te hacen sentir mal. Está bien hablar con un adulto en quien confíes, siempre es lo correcto.',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': CrayonPoseAtlas.naranjitoHandOnHeart,
          'florecita': CrayonPoseAtlas.florecitaThinkingChin,
        },
      ),
      // Diálogo Florecita decidida
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Tienes muchísima razón, Naranjito. No voy a guardar algo que no me gusta y que me hace sentir tan mal. Voy a ir ahora mismo con la maestra, ¿me acompañas, Pablito?',
        pitch: 1.29,
        rate: 0.45,
        poseChanges: {
          'florecita': CrayonPoseAtlas.florecitaDeterminedBrave,
          'naranjito': CrayonPoseAtlas.naranjitoThumbsUp,
        },
      ),
      // Diálogo Pablito acompañándola
      VoiceBeat(
        speakerId: 'pablito',
        text: 'Claro que sí, Florecita. Los amigos siempre se acompañan.',
        pitch: 1.15,
        rate: 0.45,
        poseChanges: {
          'pablito': CrayonPoseAtlas.pablitoWavingHappy,
          'florecita': CrayonPoseAtlas.florecitaDeterminedBrave,
          'naranjito': CrayonPoseAtlas.naranjitoWalkingHappy,
        },
        positionChanges: {
          'pablito': Offset(0.35, 0.65),
          'florecita': Offset(0.55, 0.66),
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'paper_dinosaur',
        normalizedPosition: Offset(0.14, 0.78),
        spokenSound: '¡Mira qué bonito quedó el dinosaurio de papel con manchas azules!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.45, 0.35),
        spokenSound: '¡Los amigos siempre se acompañan!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 4 (Fondo 2: Escritorio de la maestra - Crayon1.jpg)
  // Florecita habla con la maestra y la maestra la felicita por su honestidad
  // ===========================================================================
  StorySceneData(
    index: 3,
    backgroundAsset: 'background/stories/Crayon/Crayon1.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'maestra',
        initialPose: CrayonPoseAtlas.maestraWelcomingWarm,
        normalizedPosition: Offset(0.24, 0.62),
        scale: 1.06,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Quiero felicitarte por tu honestidad, Florecita!',
        voicePitch: 1.05,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CrayonPoseAtlas.florecitaExplainingEarnest,
        normalizedPosition: Offset(0.54, 0.67),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Qué bien se siente decir la verdad y no guardar secretos malos!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CrayonPoseAtlas.pablitoWalkingWithFriend,
        normalizedPosition: Offset(0.75, 0.66),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase: '¡Yo acompañé a mi amiga Florecita!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CrayonPoseAtlas.naranjitoHandOnHeart,
        normalizedPosition: Offset(0.88, 0.58),
        scale: 0.62,
        initialEmotion: 'happy',
        spokenPhrase: '¡Hablar con un adulto de confianza siempre es lo correcto!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Maestra, necesito contarte algo que pasó allá en mi mesa con los crayones de la caja nueva.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CrayonPoseAtlas.florecitaExplainingEarnest,
          'maestra': CrayonPoseAtlas.maestraListeningAttentive,
          'pablito': CrayonPoseAtlas.pablitoListeningCalm,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Me pidieron guardarlo como un secreto muy grande, pero no me gusta cómo se siente guardarlo, me pone muy triste y asustada. Yo no lo rompí, pero no quiero callarlo porque los secretos malos no se guardan.',
        pitch: 1.27,
        rate: 0.44,
        poseChanges: {
          'florecita': CrayonPoseAtlas.florecitaWorriedHandsClasped,
          'maestra': CrayonPoseAtlas.maestraSurprisedEmpathetic,
        },
      ),
      // Diálogo Maestra 1
      VoiceBeat(
        speakerId: 'maestra',
        text: '¿Entonces quién fue, Florecita?',
        pitch: 1.05,
        rate: 0.45,
        poseChanges: {
          'maestra': CrayonPoseAtlas.maestraAskingWho,
          'florecita': CrayonPoseAtlas.florecitaExplainingEarnest,
        },
      ),
      // Diálogo Florecita 3
      VoiceBeat(
        speakerId: 'florecita',
        text: 'Fue mi compañerito, maestra.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CrayonPoseAtlas.florecitaExplainingEarnest,
          'maestra': CrayonPoseAtlas.maestraListeningAttentive,
        },
      ),
      // Diálogo Maestra 2
      VoiceBeat(
        speakerId: 'maestra',
        text:
            'Entonces ya hablaré con tu compañerito para que no lo vuelva a hacer, pero quiero felicitarte por tu honestidad.',
        pitch: 1.05,
        rate: 0.45,
        poseChanges: {
          'maestra': CrayonPoseAtlas.maestraProudCongratulating,
          'florecita': CrayonPoseAtlas.florecitaHappyGrateful,
          'pablito': CrayonPoseAtlas.pablitoWavingHappy,
          'naranjito': CrayonPoseAtlas.naranjitoThumbsUp,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.40, 0.34),
        spokenSound: '¡La honestidad hace brillar nuestro corazón!',
      ),
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.62, 0.30),
        spokenSound: '¡Una estrella brillante por decir siempre la verdad!',
      ),
    ],
  ),
];

/// Escenas del 2do cuento: "La nube de tormenta" (Día de lluvia en el salón)
/// Fondo: `assets/images/background/stories/Nube/Nube.jpg`
/// Movimientos: `assets/images/movimientos/nube/`
const List<StorySceneData> nubeStoryScenes = [
  // ===========================================================================
  // ESCENA 1: Pablito frustrado porque llueve y Naranjito aparece para escucharlo
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Nube/Nube.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: NubePoseAtlas.pablitoAngryArmsCrossed,
        normalizedPosition: Offset(0.34, 0.64),
        scale: 1.0,
        initialEmotion: 'sad',
        spokenPhrase:
            '¡Yo quería salir a correr al patio grande con mi pelota nueva de colores!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: NubePoseAtlas.naranjitoCloudOverHead,
        normalizedPosition: Offset(0.66, 0.58),
        scale: 0.72,
        initialEmotion: 'appear',
        spokenPhrase:
            'Parece que tienes una nube de tormenta gris adentro de ti, Pablito.',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Pablito 1
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Yo quería salir a correr al patio grande! ¡No es nada justo que llueva justo hoy que trajimos juguetes nuevos!',
        pitch: 1.15,
        rate: 0.46,
        poseChanges: {
          'pablito': NubePoseAtlas.pablitoAngryShoutingFists,
          'naranjito': NubePoseAtlas.naranjitoEmpatheticAsking,
        },
      ),
      // Diálogo Pablito 2
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Yo quería usar mi pelota nueva de colores en el pasto y correr súper rápido con mis tenis nuevos que me compró mi mamá! ¡Ahora todo está arruinado!',
        pitch: 1.14,
        rate: 0.46,
        poseChanges: {
          'pablito': NubePoseAtlas.pablitoAngryHoldingBall,
          'naranjito': NubePoseAtlas.naranjitoEmpatheticAsking,
        },
      ),
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Parece que tienes una nube de tormenta gris adentro de ti, Pablito.',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': NubePoseAtlas.naranjitoCloudOverHead,
          'pablito': NubePoseAtlas.pablitoAngryArmsCrossed,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¿Sientes que tu cuerpo tiene ganas de gritar muy fuerte, o tal vez tiene ganas de llorar un poquito porque las cosas no salieron como tú querías hoy?',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': NubePoseAtlas.naranjitoEmpatheticAsking,
          'pablito': NubePoseAtlas.pablitoHandOnChestReflecting,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'storm_cloud',
        normalizedPosition: Offset(0.18, 0.28),
        spokenSound: '¡Afuera está lloviendo mucho y el patio está mojado!',
      ),
      InteractivePropData(
        type: 'colorful_ball',
        normalizedPosition: Offset(0.50, 0.80),
        spokenSound: '¡Mira qué bonita es la pelota nueva de colores de Pablito!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2: Pablito le pone nombre a lo que siente y Naranjito le muestra el paraguas
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Nube/Nube.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: NubePoseAtlas.pablitoSadHuggingBall,
        normalizedPosition: Offset(0.35, 0.65),
        scale: 1.0,
        initialEmotion: 'sad',
        spokenPhrase:
            'Estoy enojado y un poquito triste, pero respirando me siento mejor.',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: NubePoseAtlas.naranjitoHoldingUmbrella,
        normalizedPosition: Offset(0.67, 0.58),
        scale: 0.74,
        initialEmotion: 'bounce',
        spokenPhrase:
            '¡Conocer cómo se llama tu tormenta te ayuda a encontrar el mejor paraguas!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Pablito 3
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Creo que estoy muy enojado, Naranjito. Y también estoy un poquito triste, porque mi pelota no puede rodar y rebotar aquí adentro del salón.',
        pitch: 1.12,
        rate: 0.44,
        poseChanges: {
          'pablito': NubePoseAtlas.pablitoSadHuggingBall,
          'naranjito': NubePoseAtlas.naranjitoEmpatheticAsking,
        },
      ),
      // Diálogo Pablito 4
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Siento que quiero aventar la pelota muy lejos, o patear las sillas muy fuerte para que todos vean que estoy enojado.',
        pitch: 1.14,
        rate: 0.45,
        poseChanges: {
          'pablito': NubePoseAtlas.pablitoFrustratedKicking,
          'naranjito': NubePoseAtlas.naranjitoEmpatheticAsking,
        },
      ),
      // Diálogo Naranjito 3
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Conocer cómo se llama tu tormenta te ayuda a encontrar el mejor paraguas, Pablito.',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': NubePoseAtlas.naranjitoHoldingUmbrella,
          'pablito': NubePoseAtlas.pablitoHandOnChestReflecting,
        },
      ),
      // Diálogo Naranjito 4
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Cuando sabemos qué sentimos y le decimos su nombre, podemos decidir qué hacer para sentirnos mejor sin romper nada y sin lastimar a nadie. Está muy bien y es normal sentirse enojado a veces, a todos nos pasa.',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': NubePoseAtlas.naranjitoWarmSpeakingHandChest,
          'pablito': NubePoseAtlas.pablitoCalmingBreathing,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'orange_umbrella',
        normalizedPosition: Offset(0.52, 0.34),
        spokenSound:
            '¡El paraguas mágico de Naranjito nos ayuda a calmar la tormenta!',
      ),
      InteractivePropData(
        type: 'colorful_ball',
        normalizedPosition: Offset(0.22, 0.80),
        spokenSound: '¡Respiramos profundo para cuidar nuestros juguetes y amigos!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3: Florecita invita a Pablito a construir una cueva gigante con cobijas y cojines
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Nube/Nube.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: NubePoseAtlas.florecitaWalkingApproaching,
        normalizedPosition: Offset(0.27, 0.65),
        scale: 0.96,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Vamos a construir una cueva gigante con las cobijas largas y las sillas!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: NubePoseAtlas.pablitoCalmingBreathing,
        normalizedPosition: Offset(0.56, 0.65),
        scale: 0.98,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Yo traigo los cojines grandes del rincón de lectura para nuestra cueva!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: NubePoseAtlas.naranjitoGentleAdviceFinger,
        normalizedPosition: Offset(0.83, 0.58),
        scale: 0.68,
        initialEmotion: 'happy',
        spokenPhrase: '¡Qué gran idea para divertirse juntos dentro del salón!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Pablito, te escuché hablar desde allá. Ya que el patio está todo mojado por la lluvia y la maestra dice que no podemos salir a correr, ¿me ayudas a construir una cueva gigante aquí adentro?',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': NubePoseAtlas.florecitaInvitingHandsOpen,
          'pablito': NubePoseAtlas.pablitoHandOnChestReflecting,
          'naranjito': NubePoseAtlas.naranjitoWarmSpeakingHandChest,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Podemos usar las cobijas largas, las sillas de plástico y tu pelota nueva la podemos poner adentro de la cueva como si fuera un tesoro pirata escondido!',
        pitch: 1.29,
        rate: 0.45,
        poseChanges: {
          'florecita': NubePoseAtlas.florecitaExplorerSalute,
          'pablito': NubePoseAtlas.pablitoHandOnChestReflecting,
          'naranjito': NubePoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Pablito 5
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¿Una cueva gigante de verdad para nosotros solos? ¡Sí, claro que sí, Florecita!',
        pitch: 1.18,
        rate: 0.46,
        poseChanges: {
          'pablito': NubePoseAtlas.pablitoExcitedArmsUp,
          'florecita': NubePoseAtlas.florecitaClappingHappy,
          'naranjito': NubePoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Pablito 6
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Yo traigo todos los cojines grandes del rincón de lectura para que el piso de nuestra cueva esté muy suave. Ya no me siento tan enojado, mejor vamos a construir.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': NubePoseAtlas.pablitoCarryingCushionHappy,
          'florecita': NubePoseAtlas.florecitaPointingBlankets,
          'naranjito': NubePoseAtlas.naranjitoHappyThumbsUp,
        },
        positionChanges: {
          'pablito': Offset(0.62, 0.65),
          'florecita': Offset(0.34, 0.65),
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'cozy_cushion',
        normalizedPosition: Offset(0.76, 0.34),
        spokenSound:
            '¡Los cojines grandes y suaves del rincón de lectura para el piso de la cueva!',
      ),
      InteractivePropData(
        type: 'colorful_ball',
        normalizedPosition: Offset(0.45, 0.80),
        spokenSound: '¡La pelota nueva de colores será nuestro tesoro pirata escondido!',
      ),
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.46, 0.28),
        spokenSound: '¡Construir una cueva con amigos es súper divertido!',
      ),
    ],
  ),
];

/// Escenas del 3er cuento: "La burbuja personal" (Patio de la casa)
/// Fondo: `assets/images/background/stories/Burbuja/Burbuja.jpg`
/// Movimientos: `assets/images/movimientos/burbuja/`
const List<StorySceneData> burbujaStoryScenes = [
  // ===========================================================================
  // ESCENA 1 (Fondo 1: Patio de la casa - Burbuja.jpg)
  // La Tía quiere darle un abrazo de oso apretado y Naranjito le recuerda su burbuja personal
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Burbuja/Burbuja.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'tia',
        initialPose: BurbujaPoseAtlas.tiaDelightedCheeks,
        normalizedPosition: Offset(0.28, 0.63),
        scale: 1.08,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Ay, mi niña hermosa, cuánto has crecido desde la última vez que te vi!',
        voicePitch: 1.06,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: BurbujaPoseAtlas.florecitaWorriedClasped,
        normalizedPosition: Offset(0.60, 0.67),
        scale: 0.94,
        initialEmotion: 'sad',
        spokenPhrase:
            'El espacio cerquita de mí es mi burbuja personal y yo decido cómo saludar.',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: BurbujaPoseAtlas.naranjitoHoldingBubble,
        normalizedPosition: Offset(0.83, 0.57),
        scale: 0.68,
        initialEmotion: 'appear',
        spokenPhrase:
            '¡Recuerda que el espacio cerquita de ti es tu burbuja personal mágica!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Tía 1
      VoiceBeat(
        speakerId: 'tia',
        text:
            '¡Ay, mi niña hermosa, cuánto has crecido desde la última vez que te vi en tu cumpleaños!',
        pitch: 1.06,
        rate: 0.45,
        poseChanges: {
          'tia': BurbujaPoseAtlas.tiaDelightedCheeks,
          'florecita': BurbujaPoseAtlas.florecitaWorriedClasped,
        },
      ),
      // Diálogo Tía 2
      VoiceBeat(
        speakerId: 'tia',
        text:
            '¡Ven a darle un abrazo de oso muy, muy apretado a tu tía favorita! ¡Ven aquí rápido para apachurrarte con todas mis fuerzas!',
        pitch: 1.07,
        rate: 0.45,
        poseChanges: {
          'tia': BurbujaPoseAtlas.tiaBearHugArmsWide,
          'florecita': BurbujaPoseAtlas.florecitaUncomfortableTummy,
        },
      ),
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Recuerda que el espacio cerquita de ti es tu burbuja personal, Florecita. Es un espacio invisible y mágico.',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': BurbujaPoseAtlas.naranjitoHoldingBubble,
          'florecita': BurbujaPoseAtlas.florecitaThinkingChin,
          'tia': BurbujaPoseAtlas.tiaBeckoningComeHere,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Nadie, absolutamente nadie, puede entrar a tu burbuja sin tu permiso. ¿Verdad que tú eres la única dueña de tu cuerpo y tú decides cómo quieres saludar a las personas, aunque sean de tu familia?',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': BurbujaPoseAtlas.naranjitoFirmFingerUp,
          'florecita': BurbujaPoseAtlas.florecitaThinkingChin,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'magic_bubble',
        normalizedPosition: Offset(0.60, 0.36),
        spokenSound:
            '¡Tu burbuja personal es un espacio invisible y mágico alrededor de ti!',
      ),
      InteractivePropData(
        type: 'party_balloon',
        normalizedPosition: Offset(0.14, 0.24),
        spokenSound: '¡Globos de colores para celebrar en el patio!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2 (Fondo 1: Patio de la casa - Burbuja.jpg)
  // Florecita expresa lo que siente y Naranjito la anima a hablar con respeto
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Burbuja/Burbuja.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: BurbujaPoseAtlas.florecitaHandOnChestMyBody,
        normalizedPosition: Offset(0.38, 0.66),
        scale: 0.96,
        initialEmotion: 'sad',
        spokenPhrase:
            'Es mi propio cuerpo y yo decido. Puedo hablar con respeto con mi familia.',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: BurbujaPoseAtlas.naranjitoEmpatheticListening,
        normalizedPosition: Offset(0.68, 0.58),
        scale: 0.74,
        initialEmotion: 'bounce',
        spokenPhrase:
            '¡Las personas que te quieren de verdad van a entender perfectamente si les hablas con respeto!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Sí, Naranjito. Es mi propio cuerpo y yo decido. Pero me da mucha pena decirle que no quiero ese abrazo gigante.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': BurbujaPoseAtlas.florecitaHandOnChestMyBody,
          'naranjito': BurbujaPoseAtlas.naranjitoEmpatheticListening,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'No quiero que se enoje conmigo ni que piense que no la quiero, porque sí la quiero mucho, pero sus abrazos me lastiman.',
        pitch: 1.26,
        rate: 0.44,
        poseChanges: {
          'florecita': BurbujaPoseAtlas.florecitaShyLookingDown,
          'naranjito': BurbujaPoseAtlas.naranjitoEmpatheticListening,
        },
      ),
      // Diálogo Naranjito 3
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Las personas que te quieren de verdad, como tu familia, van a entender perfectamente si les hablas con respeto. No tienes que hacer nada que te incomode ni que no te guste.',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': BurbujaPoseAtlas.naranjitoWarmHandOnHeart,
          'florecita': BurbujaPoseAtlas.florecitaHandOnChestMyBody,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'magic_bubble',
        normalizedPosition: Offset(0.38, 0.34),
        spokenSound: '¡Tú eres la única dueña de tu cuerpo y de tu burbuja personal!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.54, 0.38),
        spokenSound: '¡Hablar con respeto y cariño siempre nos hace sentir seguros!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3 (Fondo 1: Patio de la casa - Burbuja.jpg)
  // Pablito saluda chocando las manos, Florecita propone chocar esos cinco y van por pastel
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Burbuja/Burbuja.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'tia',
        initialPose: BurbujaPoseAtlas.tiaListeningWarmly,
        normalizedPosition: Offset(0.22, 0.63),
        scale: 1.06,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Choca esos cinco ahora mismo y vamos a comer pastel!',
        voicePitch: 1.06,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: BurbujaPoseAtlas.florecitaSpeakingRespectfully,
        normalizedPosition: Offset(0.50, 0.67),
        scale: 0.94,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Mejor te saludo chocando las manos súper fuerte como Pablito!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: BurbujaPoseAtlas.pablitoWavingHappy,
        normalizedPosition: Offset(0.73, 0.66),
        scale: 0.95,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Hola, tía de Florecita! ¡Hay mucho pastel en la fiesta de hoy!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: BurbujaPoseAtlas.naranjitoHappyThumbsUp,
        normalizedPosition: Offset(0.89, 0.58),
        scale: 0.62,
        initialEmotion: 'happy',
        spokenPhrase: '¡Qué bien se siente decidir cómo queremos saludar!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Pablito
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Hola, tía de Florecita! ¡Qué bueno que vino a la fiesta de hoy, hay mucho pastel!',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': BurbujaPoseAtlas.pablitoPointingCake,
          'tia': BurbujaPoseAtlas.tiaHighFiveRaised,
          'florecita': BurbujaPoseAtlas.florecitaWelcomingOpenHand,
        },
      ),
      // Diálogo Florecita 3
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Hola, tía. Qué bueno verte. Hoy no quiero abrazos de oso porque me aprietan mucho, me dejan sin aire y no me gustan.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': BurbujaPoseAtlas.florecitaSpeakingRespectfully,
          'tia': BurbujaPoseAtlas.tiaListeningWarmly,
          'pablito': BurbujaPoseAtlas.pablitoWavingHappy,
        },
      ),
      // Diálogo Florecita 4
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Mejor te saludo chocando las manos súper fuerte como lo acaba de hacer Pablito.',
        pitch: 1.29,
        rate: 0.45,
        poseChanges: {
          'florecita': BurbujaPoseAtlas.florecitaHighFiveRaised,
          'tia': BurbujaPoseAtlas.tiaUnderstandingHandOnHeart,
          'pablito': BurbujaPoseAtlas.pablitoHighFiveGreeting,
        },
      ),
      // Diálogo Tía 3
      VoiceBeat(
        speakerId: 'tia',
        text:
            '¡Claro que sí, mi niña hermosa! Tienes toda la razón, a veces mis abrazos de oso son demasiados fuertes para ti. ¡Choca esos cinco ahora mismo y vamos a comer pastel!',
        pitch: 1.07,
        rate: 0.45,
        poseChanges: {
          'tia': BurbujaPoseAtlas.tiaHighFiveRaised,
          'florecita': BurbujaPoseAtlas.florecitaHappyHandsCheeks,
          'pablito': BurbujaPoseAtlas.pablitoJumpingJoy,
          'naranjito': BurbujaPoseAtlas.naranjitoHappyThumbsUp,
        },
        positionChanges: {
          'tia': Offset(0.30, 0.63),
          'florecita': Offset(0.48, 0.67),
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'birthday_cake',
        normalizedPosition: Offset(0.63, 0.42),
        spokenSound: '¡Qué rico pastel de cumpleaños con velitas encendidas!',
      ),
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.39, 0.32),
        spokenSound: '¡Choca esos cinco con mucha alegría!',
      ),
    ],
  ),
];

/// Escenas del 4to cuento: "El papalote en el árbol"
/// Fondo 1: `assets/images/background/stories/Papalote/Papalote1.jpg` (Con papalote en la rama)
/// Fondo 2: `assets/images/background/stories/Papalote/Papalote2.jpg` (Sin papalote en la rama)
/// Movimientos: `assets/images/movimientos/papalote/`
const List<StorySceneData> papaloteStoryScenes = [
  // ===========================================================================
  // ESCENA 1 (Fondo 1: Parque con árboles y papalote - Papalote1.jpg)
  // Pablito intenta alcanzar el papalote sobre el bote de basura y Naranjito le aconseja
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Papalote/Papalote1.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: PapalotePoseAtlas.pablitoReachingUpOnTiptoes,
        normalizedPosition: Offset(0.24, 0.62),
        scale: 0.96,
        initialEmotion: 'sad',
        spokenPhrase:
            'Mi papalote está muy alto en esa rama y quiero alcanzarlo.',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: PapalotePoseAtlas.naranjitoWorriedLookingUp,
        normalizedPosition: Offset(0.58, 0.58),
        scale: 0.72,
        initialEmotion: 'appear',
        spokenPhrase:
            '¡Pedir ayuda a un adulto para estar a salvo también es de valientes!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Pablito 1
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Mi papalote está muy alto en esa rama. Si me estiro mucho más arriba de este bote de basura, tal vez alcance la cuerda del papalote.',
        pitch: 1.15,
        rate: 0.45,
        poseChanges: {
          'pablito': PapalotePoseAtlas.pablitoReachingUpOnTiptoes,
          'naranjito': PapalotePoseAtlas.naranjitoWorriedLookingUp,
        },
      ),
      // Diálogo Pablito 2
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Tengo que hacerlo yo solo para demostrarles a todos mis amigos que soy grande, muy fuerte y muy valiente! ¡Nadie me va a ayudar!',
        pitch: 1.16,
        rate: 0.46,
        poseChanges: {
          'pablito': PapalotePoseAtlas.pablitoHandsOnHipsProud,
          'naranjito': PapalotePoseAtlas.naranjitoStopWaitHand,
        },
      ),
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Oye, Pablito, escúchame bien. ¿Y si en lugar de saltar desde ahí y arriesgarnos a caer muy feo al piso, buscamos a alguien que sea mucho más alto y sepa cómo hacerlo de forma segura?',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': PapalotePoseAtlas.naranjitoWorriedLookingUp,
          'pablito': PapalotePoseAtlas.pablitoThinkingChin,
        },
      ),
      // Diálogo Pablito 3
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Pero si voy a pedir ayuda, todos los niños van a pensar que soy un niño pequeño que no sabe cuidar sus propios juguetes. Yo puedo hacerlo solo, solo me falta estirarme un poquito más.',
        pitch: 1.14,
        rate: 0.45,
        poseChanges: {
          'pablito': PapalotePoseAtlas.pablitoStubbornArmsCrossed,
          'naranjito': PapalotePoseAtlas.naranjitoStopWaitHand,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Los niños más grandes y valientes no son los que hacen todo solos siempre, Pablito.',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': PapalotePoseAtlas.naranjitoWiseFingerUp,
          'pablito': PapalotePoseAtlas.pablitoThinkingChin,
        },
      ),
      // Diálogo Naranjito 3
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Son los que son muy listos y saben cuándo necesitan a su equipo, o a un adulto, para estar a salvo y no lastimarse su cuerpo. Pedir ayuda también es de valientes.',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': PapalotePoseAtlas.naranjitoWarmHandOnHeart,
          'pablito': PapalotePoseAtlas.pablitoShyHandsClasped,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'flying_kite',
        normalizedPosition: Offset(0.35, 0.22),
        spokenSound: '¡El papalote de colores se quedó atorado muy alto en la rama!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2 (Fondo 1: Parque con árboles y papalote - Papalote1.jpg)
  // Florecita le advierte del bote inestable y van con su papá que lee en la banca azul
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Papalote/Papalote1.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: PapalotePoseAtlas.pablitoScaredAlmostSlipped,
        normalizedPosition: Offset(0.24, 0.64),
        scale: 0.94,
        initialEmotion: 'sad',
        spokenPhrase:
            '¡Casi me resbalo! Mejor le pedimos ayuda al papá de Florecita.',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: PapalotePoseAtlas.florecitaCallingHandsMouth,
        normalizedPosition: Offset(0.46, 0.66),
        scale: 0.92,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Mi papá está leyendo en la banca azul y él es altísimo!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: PapalotePoseAtlas.naranjitoHappyThumbsUp,
        normalizedPosition: Offset(0.62, 0.56),
        scale: 0.62,
        initialEmotion: 'bounce',
        spokenPhrase: '¡Qué buena decisión bajar de ahí y pedir ayuda!',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'papa',
        initialPose: PapalotePoseAtlas.papaSittingReadingBook,
        normalizedPosition: Offset(0.81, 0.62),
        scale: 1.06,
        initialEmotion: 'happy',
        spokenPhrase: '¡Claro que sí hija, vamos a bajar el papalote!',
        voicePitch: 0.88,
      ),
    ],
    beats: [
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Pablito, bájate de ahí ahora mismo, por favor! Ese bote de basura se mueve mucho, se va a voltear de lado y te vas a caer al piso duro.',
        pitch: 1.29,
        rate: 0.45,
        poseChanges: {
          'florecita': PapalotePoseAtlas.florecitaWorriedStopHand,
          'pablito': PapalotePoseAtlas.pablitoScaredAlmostSlipped,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Mi papá está leyendo su libro muy cerca de aquí en la banca azul. Él es altísimo, él puede alcanzar tu papalote sin subirse a nada peligroso.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': PapalotePoseAtlas.florecitaPointingToBench,
          'pablito': PapalotePoseAtlas.pablitoThinkingChin,
          'papa': PapalotePoseAtlas.papaSittingReadingBook,
        },
      ),
      // Diálogo Pablito 4
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Tienes mucha razón, Florecita y Naranjito. La verdad es que me dio muchísimo miedo estar ahí arriba porque todo se movía y casi me resbalo.',
        pitch: 1.14,
        rate: 0.45,
        poseChanges: {
          'pablito': PapalotePoseAtlas.pablitoScaredAlmostSlipped,
          'florecita': PapalotePoseAtlas.florecitaAgreeingOpenHand,
          'naranjito': PapalotePoseAtlas.naranjitoWarmHandOnHeart,
        },
        positionChanges: {
          'pablito': Offset(0.30, 0.66),
        },
      ),
      // Diálogo Pablito 5
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Prefiero que mi papalote esté atorado un ratito más, a caerme y rasparme las rodillas. ¿Me acompañas a pedirle ayuda a tu papá, por favor?',
        pitch: 1.15,
        rate: 0.45,
        poseChanges: {
          'pablito': PapalotePoseAtlas.pablitoAskingForHelpPointing,
          'florecita': PapalotePoseAtlas.florecitaAgreeingOpenHand,
          'naranjito': PapalotePoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Florecita 3
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Claro que sí, Pablito, vamos a hablar con mi papá... Hola papá, ¿nos ayudas a bajar el papalote de Pablito? Es que se subió muy alto y ahora no lo podemos alcanzar.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': PapalotePoseAtlas.florecitaPointingUpAtKite,
          'pablito': PapalotePoseAtlas.pablitoWalkingCarefully,
          'papa': PapalotePoseAtlas.papaSittingLookingUpSmiling,
        },
        positionChanges: {
          'florecita': Offset(0.56, 0.66),
          'pablito': Offset(0.40, 0.66),
        },
      ),
      // Diálogo Papá 1
      VoiceBeat(
        speakerId: 'papa',
        text: 'Claro que sí hija, vamos a bajar el papalote.',
        pitch: 0.88,
        rate: 0.45,
        poseChanges: {
          'papa': PapalotePoseAtlas.papaReachingUpForKite,
          'florecita': PapalotePoseAtlas.florecitaHappyGratefulHands,
          'pablito': PapalotePoseAtlas.pablitoShyHandsClasped,
        },
        positionChanges: {
          'papa': Offset(0.36, 0.60),
          'florecita': Offset(0.58, 0.66),
          'pablito': Offset(0.72, 0.66),
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'flying_kite',
        normalizedPosition: Offset(0.35, 0.22),
        spokenSound: '¡El papá de Florecita es muy alto y alcanza el papalote sin peligro!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.75, 0.36),
        spokenSound: '¡Pedir ayuda a un adulto de confianza nos mantiene seguros!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3 (Fondo 2: Parque con árboles sin papalote - Papalote2.jpg)
  // El papá les entrega el papalote y les agradece su confianza
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Papalote/Papalote2.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'papa',
        initialPose: PapalotePoseAtlas.papaHandingKiteToPablito,
        normalizedPosition: Offset(0.28, 0.61),
        scale: 1.12,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Siempre pueden contar conmigo cuando necesiten ayuda!',
        voicePitch: 0.88,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: PapalotePoseAtlas.pablitoShyHandsClasped,
        normalizedPosition: Offset(0.54, 0.66),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Muchas gracias señor, ahora podremos seguir jugando con mi papalote!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: PapalotePoseAtlas.florecitaHappyGratefulHands,
        normalizedPosition: Offset(0.74, 0.66),
        scale: 0.93,
        initialEmotion: 'happy',
        spokenPhrase: '¡Qué alegría que el papalote ya está de vuelta!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: PapalotePoseAtlas.naranjitoHappyThumbsUp,
        normalizedPosition: Offset(0.89, 0.58),
        scale: 0.62,
        initialEmotion: 'happy',
        spokenPhrase: '¡Pedir ayuda también es de valientes!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Papá 2 (Fondo 2: sin papalote en el árbol)
      VoiceBeat(
        speakerId: 'papa',
        text: 'Aquí tienen su papalote.',
        pitch: 0.88,
        rate: 0.45,
        poseChanges: {
          'papa': PapalotePoseAtlas.papaHandingKiteToPablito,
          'pablito': PapalotePoseAtlas.pablitoShyHandsClasped,
          'florecita': PapalotePoseAtlas.florecitaHappyGratefulHands,
        },
      ),
      // Diálogo Pablito 6
      VoiceBeat(
        speakerId: 'pablito',
        text: 'Muchas gracias señor, ahora podremos seguir jugando.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': PapalotePoseAtlas.pablitoHoldingKiteHappy,
          'papa': PapalotePoseAtlas.papaStandingWarmSmile,
          'florecita': PapalotePoseAtlas.florecitaHappyGratefulHands,
        },
      ),
      // Diálogo Papá 3
      VoiceBeat(
        speakerId: 'papa',
        text:
            'Claro que sí, saben que siempre pueden contar conmigo, también les agradezco que me hayan tenido la confianza de contarme lo que les pasó para poder ayudarles, no quiero imaginarme lo que hubiera pasado si se cayeran intentando alcanzar el papalote.',
        pitch: 0.88,
        rate: 0.45,
        poseChanges: {
          'papa': PapalotePoseAtlas.papaHandOnHeartProud,
          'pablito': PapalotePoseAtlas.pablitoHoldingKiteHappy,
          'florecita': PapalotePoseAtlas.florecitaHappyGratefulHands,
          'naranjito': PapalotePoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'flying_kite',
        normalizedPosition: Offset(0.54, 0.32),
        spokenSound: '¡A volar el papalote de colores en el parque!',
      ),
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.38, 0.28),
        spokenSound: '¡Una estrella brillante por saber pedir ayuda a tiempo!',
      ),
    ],
   ),
];

/// Story 5 ("La niña nueva") — structured into 3 scenes
/// using `Companera1.jpg` (patio con banca) and `Companera2.jpg` (mesa de juegos con sombrilla).
const List<StorySceneData> companeraStoryScenes = [
  // ===========================================================================
  // ESCENA 1 (Patio de recreo con banca - Companera1.jpg)
  // Florecita ve a la niña nueva solita en la banca y Naranjito la invita a empatizar
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Companera/Companera1.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CompaneraPoseAtlas.florecitaPointingRight,
        normalizedPosition: Offset(0.20, 0.67),
        scale: 0.94,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡Yo quisiera que alguien amable me invitara a jugar en mi primer día!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CompaneraPoseAtlas.naranjitoEmpatheticSmile,
        normalizedPosition: Offset(0.38, 0.56),
        scale: 0.65,
        initialEmotion: 'appear',
        spokenPhrase:
            '¡Un pequeño saludo y una sonrisa bonita pueden cambiarle el día completo!',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CompaneraPoseAtlas.pablitoHoldingDinoHappy,
        normalizedPosition: Offset(0.55, 0.68),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase: '¡Vamos a invitar a la niña nueva a jugar con nosotros!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'companera',
        initialPose: CompaneraPoseAtlas.companeraSittingOnBenchShy,
        normalizedPosition: Offset(0.80, 0.63),
        scale: 0.92,
        initialEmotion: 'sad',
        spokenPhrase: 'Es mi primer día en la escuela y me da un poquito de pena.',
        voicePitch: 1.32,
      ),
    ],
    beats: [
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Pablito, mira hacia allá. Esa niña nueva con la mochila de estrellitas no juega con nadie en todo el recreo.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CompaneraPoseAtlas.florecitaPointingRight,
          'pablito': CompaneraPoseAtlas.pablitoSettingDinoDownLooking,
          'companera': CompaneraPoseAtlas.companeraSittingOnBenchShy,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Seguro prefiere estar completamente sola y por eso no nos habla ni se acerca a nuestros juegos. Yo creo que no deberíamos molestarla si quiere estar sentada ahí en silencio.',
        pitch: 1.26,
        rate: 0.45,
        poseChanges: {
          'florecita': CompaneraPoseAtlas.florecitaThinkingHandOnChin,
          'pablito': CompaneraPoseAtlas.pablitoSettingDinoDownLooking,
          'naranjito': CompaneraPoseAtlas.naranjitoEmpatheticSmile,
        },
      ),
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'A veces, estar solo no es porque uno quiera estarlo, sino porque da mucha, mucha pena hablar primero con niños que no conoces.',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CompaneraPoseAtlas.naranjitoEmpatheticSmile,
          'florecita': CompaneraPoseAtlas.florecitaThinkingHandOnChin,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Piensa un ratito, Florecita... ¿Cómo te gustaría que te trataran a ti si fuera tu primerísimo día en una escuela nueva donde no conoces absolutamente a nadie?',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CompaneraPoseAtlas.naranjitoPensiveHandOnChin,
          'florecita': CompaneraPoseAtlas.florecitaThinkingHandOnChin,
        },
      ),
      // Diálogo Florecita 3
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Cuando yo llegué a esta escuela el primer día, me dio muchísimo miedo acercarme a los demás niños.',
        pitch: 1.22,
        rate: 0.44,
        poseChanges: {
          'florecita': CompaneraPoseAtlas.florecitaSadHandsChest,
          'naranjito': CompaneraPoseAtlas.naranjitoHandOnHeartGesture,
          'pablito': CompaneraPoseAtlas.pablitoEmpatheticOpenHands,
        },
      ),
      // Diálogo Florecita 4
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Tenía muchas ganas de llorar del susto hasta que tú me hablaste por primera vez, Pablito. Yo quisiera que alguien amable me invitara a jugar para no estar tan solita y triste.',
        pitch: 1.26,
        rate: 0.45,
        poseChanges: {
          'florecita': CompaneraPoseAtlas.florecitaWarmSmileLookingUp,
          'pablito': CompaneraPoseAtlas.pablitoHoldingDinoHappy,
          'naranjito': CompaneraPoseAtlas.naranjitoHandOnHeartGesture,
        },
      ),
      // Diálogo Naranjito 3
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Exactamente, Florecita. Un pequeño saludo y una sonrisa bonita pueden cambiarle el día completo a alguien que se siente solito o asustado.',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CompaneraPoseAtlas.naranjitoPointingToBigSmile,
          'florecita': CompaneraPoseAtlas.florecitaWarmSmileLookingUp,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.78, 0.34),
        spokenSound: '¡Una estrella brillante para darle la bienvenida a la niña nueva!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.38, 0.30),
        spokenSound: '¡Una sonrisa amable alegra el corazón!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2 (Florecita y Pablito se acercan a saludarla - Companera1.jpg)
  // Florecita invita a Pablito a dejar sus juguetes un momento y saludan a la compañerita
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Companera/Companera1.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CompaneraPoseAtlas.naranjitoHappyThumbsUp,
        normalizedPosition: Offset(0.16, 0.56),
        scale: 0.62,
        initialEmotion: 'happy',
        spokenPhrase: '¡Qué bonito es hacer nuevos amigos!',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CompaneraPoseAtlas.florecitaBeckoningComeWithMe,
        normalizedPosition: Offset(0.34, 0.67),
        scale: 0.95,
        initialEmotion: 'walk',
        spokenPhrase: '¡Hola! Me llamo Florecita y él es mi mejor amigo Pablito.',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CompaneraPoseAtlas.pablitoSettingDinoDownLooking,
        normalizedPosition: Offset(0.52, 0.68),
        scale: 0.95,
        initialEmotion: 'walk',
        spokenPhrase: '¡Hola! ¡Vamos a jugar juntos!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'companera',
        initialPose: CompaneraPoseAtlas.companeraSittingOnBenchShy,
        normalizedPosition: Offset(0.79, 0.63),
        scale: 0.92,
        initialEmotion: 'happy',
        spokenPhrase: '¡Hola Florecita, hola Pablito!',
        voicePitch: 1.32,
      ),
    ],
    beats: [
      // Diálogo Florecita 5
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Pablito, deja tus juguetes un momento y acompáñame. Vamos a invitarla a jugar a nuestra mesa ahora mismo para que ya no esté sola.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CompaneraPoseAtlas.florecitaBeckoningComeWithMe,
          'pablito': CompaneraPoseAtlas.pablitoSettingDinoDownLooking,
          'naranjito': CompaneraPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Florecita 6
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Hola, ¿cómo estás? Me llamo Florecita y él es mi mejor amigo Pablito.',
        pitch: 1.30,
        rate: 0.45,
        poseChanges: {
          'florecita': CompaneraPoseAtlas.florecitaWavingHello,
          'pablito': CompaneraPoseAtlas.pablitoWavingHello,
          'companera': CompaneraPoseAtlas.companeraStandingSurprised,
        },
        positionChanges: {
          'florecita': Offset(0.42, 0.67),
          'pablito': Offset(0.58, 0.68),
          'companera': Offset(0.78, 0.67),
        },
      ),
      // Diálogo Compañerita 1
      VoiceBeat(
        speakerId: 'companera',
        text:
            'Hola Florecita, hola Pablito, estoy muy bien gracias ¿y ustedes?',
        pitch: 1.33,
        rate: 0.45,
        poseChanges: {
          'companera': CompaneraPoseAtlas.companeraWavingShyly,
          'florecita': CompaneraPoseAtlas.florecitaPresentingGesture,
          'pablito': CompaneraPoseAtlas.pablitoWavingHello,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.60, 0.34),
        spokenSound: '¡Qué alegría saludar a una nueva amiga!',
      ),
      InteractivePropData(
        type: 'paper_dinosaur',
        normalizedPosition: Offset(0.48, 0.82),
        spokenSound: '¡El dinosaurio de juguete de Pablito también quiere jugar!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3 (En la mesa de juegos con sombrilla - Companera2.jpg)
  // Pablito y Florecita la invitan a jugar con todos los juguetes y ser su amiga
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Companera/Companera2.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CompaneraPoseAtlas.pablitoShowingToyCar,
        normalizedPosition: Offset(0.22, 0.68),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Tenemos dinosaurios, carritos y pelotas para jugar todos juntos!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CompaneraPoseAtlas.florecitaPresentingGesture,
        normalizedPosition: Offset(0.44, 0.67),
        scale: 0.94,
        initialEmotion: 'happy',
        spokenPhrase: '¡Qué bonito es tener una nueva amiga para jugar todos los días!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CompaneraPoseAtlas.naranjitoHandOnHeartGesture,
        normalizedPosition: Offset(0.60, 0.54),
        scale: 0.62,
        initialEmotion: 'happy',
        spokenPhrase: '¡Invitar a jugar a alguien nuevo lo hace sentir muy feliz!',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'companera',
        initialPose: CompaneraPoseAtlas.companeraStandingShyHandsClasped,
        normalizedPosition: Offset(0.77, 0.67),
        scale: 0.93,
        initialEmotion: 'happy',
        spokenPhrase: '¡Sí quiero ser su amiga y jugar con ustedes!',
        voicePitch: 1.33,
      ),
    ],
    beats: [
      // Diálogo Pablito 1
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Igual estamos muy bien, con muchas ganas de jugar, tenemos dinosaurios, carritos, pelotas, bueno de todos los juguetes… ¿Qué quieres jugar?',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': CompaneraPoseAtlas.pablitoShowingToyCar,
          'florecita': CompaneraPoseAtlas.florecitaPresentingGesture,
          'companera': CompaneraPoseAtlas.companeraStandingShyHandsClasped,
        },
      ),
      // Diálogo Compañerita 2
      VoiceBeat(
        speakerId: 'companera',
        text:
            'Me gustaría jugar a todo pero me da pena porque es mi primer día.',
        pitch: 1.33,
        rate: 0.45,
        poseChanges: {
          'companera': CompaneraPoseAtlas.companeraFingerOnChinShy,
          'pablito': CompaneraPoseAtlas.pablitoEmpatheticOpenHands,
          'florecita': CompaneraPoseAtlas.florecitaWarmSmileLookingUp,
        },
      ),
      // Diálogo Florecita 7
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'También me pasó lo mismo en mi primer día, después hice amigos y jugamos todos los días, ¿quieres ser nuestra amiga?',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CompaneraPoseAtlas.florecitaOfferingHandToFriend,
          'companera': CompaneraPoseAtlas.companeraHappyHandsTogether,
          'naranjito': CompaneraPoseAtlas.naranjitoPointingToBigSmile,
        },
      ),
      // Diálogo Pablito 2
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Sí, claro que sí! ¡Acepta ser nuestra amiga para que juguemos todos los juegos del mundo!',
        pitch: 1.18,
        rate: 0.45,
        poseChanges: {
          'pablito': CompaneraPoseAtlas.pablitoArmsRaisedExcited,
          'florecita': CompaneraPoseAtlas.florecitaOfferingHandToFriend,
          'naranjito': CompaneraPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Compañerita 3
      VoiceBeat(
        speakerId: 'companera',
        text: '¡Sí quiero ser su amiga!',
        pitch: 1.35,
        rate: 0.45,
        poseChanges: {
          'companera': CompaneraPoseAtlas.companeraArmsWideOpenHappy,
          'florecita': CompaneraPoseAtlas.florecitaWavingHello,
          'pablito': CompaneraPoseAtlas.pablitoArmsRaisedExcited,
          'naranjito': CompaneraPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'colorful_ball',
        normalizedPosition: Offset(0.32, 0.82),
        spokenSound: '¡La pelota de colores rebota para jugar con nuestra nueva amiga!',
      ),
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.75, 0.28),
        spokenSound: '¡Qué alegría tener una nueva mejor amiga en la escuela!',
      ),
    ],
  ),
];

/// Story 6 ("Juegos seguros en el patio grande") — structured into 3 scenes
/// using `Juegos1.jpg` (patio grande), `Juegos2.jpg` (columpios y resbaladilla), and `Juegos3.jpg` (pasillo hacia la maestra).
const List<StorySceneData> juegosStoryScenes = [
  // ===========================================================================
  // ESCENA 1 (Patio grande con canchas - Juegos1.jpg)
  // El niño mayor empuja fuerte a Pablito jugando a las traes y Naranjito reflexiona con él
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Juegos/Juegos1.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'nino_mayor',
        initialPose: JuegosPoseAtlas.ninoMayorRunningTagging,
        normalizedPosition: Offset(0.26, 0.65),
        scale: 1.04,
        initialEmotion: 'talk',
        spokenPhrase: '¡Estábamos jugando a atrapar en el patio grande!',
        voicePitch: 0.96,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: JuegosPoseAtlas.pablitoFallingPushed,
        normalizedPosition: Offset(0.56, 0.68),
        scale: 0.95,
        initialEmotion: 'sad',
        spokenPhrase:
            '¡Me dolió mucho la rodilla cuando me empujaron al suelo!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: JuegosPoseAtlas.naranjitoJumpingHappy,
        normalizedPosition: Offset(0.80, 0.56),
        scale: 0.65,
        initialEmotion: 'appear',
        spokenPhrase:
            '¡Jugar es divertido cuando todos estamos seguros y nadie sale lastimado!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Niño Mayor 1
      VoiceBeat(
        speakerId: 'nino_mayor',
        text:
            '¡Las traes, te toqué! ¡Te atrapé súper rápido! ¡Eres muy lento!',
        pitch: 0.96,
        rate: 0.47,
        poseChanges: {
          'nino_mayor': JuegosPoseAtlas.ninoMayorRunningTagging,
          'pablito': JuegosPoseAtlas.pablitoFallingPushed,
        },
      ),
      // Diálogo Niño Mayor 2
      VoiceBeat(
        speakerId: 'nino_mayor',
        text:
            '¡Así se juega a atrapar aquí en el patio grande! Tienes que aguantar los empujones fuertes si quieres jugar con los niños mayores. Si vas a llorar, mejor vete a otro lado.',
        pitch: 0.95,
        rate: 0.46,
        poseChanges: {
          'nino_mayor': JuegosPoseAtlas.ninoMayorPointingBoastful,
          'pablito': JuegosPoseAtlas.pablitoSittingHurtKnee,
        },
      ),
      // Diálogo Pablito 1
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Ay! ¡Mi rodilla! ¿Por qué me empujaste tan fuerte? ¡Me caí y me duele mucho!',
        pitch: 1.18,
        rate: 0.45,
        poseChanges: {
          'pablito': JuegosPoseAtlas.pablitoSittingHurtKnee,
          'nino_mayor': JuegosPoseAtlas.ninoMayorHandsOnHipsDismissive,
        },
      ),
      // Diálogo Niño Mayor 3
      VoiceBeat(
        speakerId: 'nino_mayor',
        text:
            '¡No exageres! ¡Solo estábamos jugando! ¡Levántate y sigue corriendo!',
        pitch: 0.96,
        rate: 0.46,
        poseChanges: {
          'nino_mayor': JuegosPoseAtlas.ninoMayorShruggingExaggerating,
          'pablito': JuegosPoseAtlas.pablitoSittingHurtKnee,
        },
      ),
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Qué divertido es jugar con los amigos! Podemos correr, saltar y reír muchísimo. Pero, Pablito, ¿crees que todos se están divirtiendo cuando alguien termina lastimado?',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': JuegosPoseAtlas.naranjitoPensiveHandOnChin,
          'pablito': JuegosPoseAtlas.pablitoStandingTearsHurtKnee,
          'nino_mayor': JuegosPoseAtlas.ninoMayorHandsOnHipsDismissive,
        },
      ),
      // Diálogo Pablito 2
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'No, Naranjito. A mí no me dio nada de risa. Me dolió muchísimo la rodilla y me asusté cuando caí al suelo. Yo solo quería jugar y divertirme.',
        pitch: 1.12,
        rate: 0.44,
        poseChanges: {
          'pablito': JuegosPoseAtlas.pablitoStandingTearsHurtKnee,
          'naranjito': JuegosPoseAtlas.naranjitoHandOnHeartWarm,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'colorful_ball',
        normalizedPosition: Offset(0.42, 0.82),
        spokenSound: '¡En el patio grande jugamos sin empujar a nuestros amigos!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.76, 0.30),
        spokenSound: '¡Cuidar a nuestros amigos hace que el juego sea divertido para todos!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2 (Área de columpios y resbaladilla - Juegos2.jpg)
  // Florecita llega desde los columpios para ayudar a Pablito y ponen un límite con respeto
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Juegos/Juegos2.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: JuegosPoseAtlas.florecitaRunningWorried,
        normalizedPosition: Offset(0.20, 0.67),
        scale: 0.94,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Los juegos deben ser divertidos y seguros para todos!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: JuegosPoseAtlas.pablitoStandingTearsHurtKnee,
        normalizedPosition: Offset(0.44, 0.68),
        scale: 0.95,
        initialEmotion: 'sad',
        spokenPhrase:
            '¡No me gusta que me empujen, para jugar juntos hay que respetarnos!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: JuegosPoseAtlas.naranjitoHandOnHeartWarm,
        normalizedPosition: Offset(0.62, 0.54),
        scale: 0.63,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡Si algo nos lastima podemos decir que no nos gusta y pedir ayuda!',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'nino_mayor',
        initialPose: JuegosPoseAtlas.ninoMayorHandsOnHipsDismissive,
        normalizedPosition: Offset(0.81, 0.65),
        scale: 1.04,
        initialEmotion: 'talk',
        spokenPhrase: 'Estoy aprendiendo que empujar fuerte puede lastimar a los demás.',
        voicePitch: 0.96,
      ),
    ],
    beats: [
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Pablito! ¿Estás bien? Te vi caer desde los columpios. ¿Necesitas ayuda?',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': JuegosPoseAtlas.florecitaHelpingHandDown,
          'pablito': JuegosPoseAtlas.pablitoStandingTearsHurtKnee,
        },
        positionChanges: {
          'florecita': Offset(0.24, 0.67),
        },
      ),
      // Diálogo Pablito 3
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Me duele la rodilla, Florecita. El niño mayor me empujó muy fuerte y después dijo que no debía llorar porque así se juega.',
        pitch: 1.14,
        rate: 0.44,
        poseChanges: {
          'pablito': JuegosPoseAtlas.pablitoExplainingSadHandsOpen,
          'florecita': JuegosPoseAtlas.florecitaWorriedHandsChest,
          'naranjito': JuegosPoseAtlas.naranjitoHandOnHeartWarm,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Eso no está bien! Los juegos deben ser divertidos y seguros. Nadie tiene que empujar ni lastimar a sus amigos para demostrar que es más fuerte.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': JuegosPoseAtlas.florecitaFirmFingerUp,
          'pablito': JuegosPoseAtlas.pablitoExplainingSadHandsOpen,
          'nino_mayor': JuegosPoseAtlas.ninoMayorHandsOnHipsDismissive,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Así es! Todos tenemos derecho a jugar tranquilos. Si algo nos lastima o nos hace sentir miedo, podemos decir que no nos gusta y pedir ayuda.',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': JuegosPoseAtlas.naranjitoWiseFingerUp,
          'florecita': JuegosPoseAtlas.florecitaExplainingBothHands,
        },
      ),
      // Diálogo Pablito 4
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Tienes razón! No quiero volver a jugar así. Podemos correr y divertirnos sin empujarnos ni hacernos daño.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': JuegosPoseAtlas.pablitoPointingFirm,
          'florecita': JuegosPoseAtlas.florecitaEncouragingSmile,
          'naranjito': JuegosPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Niño Mayor 4
      VoiceBeat(
        speakerId: 'nino_mayor',
        text:
            '¡Pero todos los niños mayores juegan así! ¡No tienes que quejarte por cualquier cosita!',
        pitch: 0.96,
        rate: 0.46,
        poseChanges: {
          'nino_mayor': JuegosPoseAtlas.ninoMayorShruggingExaggerating,
          'pablito': JuegosPoseAtlas.pablitoPointingFirm,
        },
      ),
      // Diálogo Pablito 5
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'No importa si eres mayor o pequeño. No me gusta que me empujes. Si quieres jugar conmigo, tienes que respetarme.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': JuegosPoseAtlas.pablitoStopHandFirm,
          'nino_mayor': JuegosPoseAtlas.ninoMayorArmsCrossedFrowning,
          'florecita': JuegosPoseAtlas.florecitaEncouragingSmile,
        },
      ),
      // Diálogo Florecita 3
      VoiceBeat(
        speakerId: 'florecita',
        text: 'Y si alguien se lastima, debemos ayudarlo, no burlarnos de él.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': JuegosPoseAtlas.florecitaExtendingHandSide,
          'nino_mayor': JuegosPoseAtlas.ninoMayorThinkingChinReflecting,
          'naranjito': JuegosPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.34, 0.30),
        spokenSound: '¡Si un amigo se cae, lo ayudamos con cariño!',
      ),
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.66, 0.28),
        spokenSound: '¡Decir lo que no nos gusta con firmeza y respeto es muy valiente!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3 (Pasillo hacia el salón de la maestra - Juegos3.jpg)
  // Pablito y Florecita van a contarle a la maestra y Naranjito celebra su aprendizaje
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Juegos/Juegos3.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: JuegosPoseAtlas.florecitaPresentingWarmly,
        normalizedPosition: Offset(0.28, 0.67),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase: '¡La maestra siempre nos ayuda para que juguemos seguros!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: JuegosPoseAtlas.pablitoWalkingDetermined,
        normalizedPosition: Offset(0.52, 0.68),
        scale: 0.96,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Vamos a contarle a la maestra para jugar todos sin lastimarnos!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: JuegosPoseAtlas.naranjitoHappyThumbsUp,
        normalizedPosition: Offset(0.76, 0.58),
        scale: 0.68,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Los mejores juegos son aquellos en los que todos podemos sonreír!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Pablito 6
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Vamos a contarle a la maestra lo que pasó. Ella puede ayudarnos para que todos podamos jugar sin lastimarnos.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': JuegosPoseAtlas.pablitoWalkingDetermined,
          'florecita': JuegosPoseAtlas.florecitaPresentingWarmly,
          'naranjito': JuegosPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Naranjito 3
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Muy bien, Pablito! Recuerda que un buen amigo no necesita empujar ni lastimar para divertirse. ¡Los mejores juegos son aquellos en los que todos podemos sonreír!',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': JuegosPoseAtlas.naranjitoArmsOpenBigSmile,
          'pablito': JuegosPoseAtlas.pablitoJumpingHappy,
          'florecita': JuegosPoseAtlas.florecitaHappyHandsChest,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.52, 0.28),
        spokenSound: '¡Los mejores juegos son aquellos en los que todos podemos sonreír!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.78, 0.32),
        spokenSound: '¡Un buen amigo te cuida y te respeta cuando juegan!',
      ),
    ],
  ),
];

/// Story 7 ("La pieza perdida del rompecabezas") — structured into 3 scenes
/// using `Pieza1.jpg` (alfombra y silla), `Pieza2.jpg` (Fondo 2: Mesa de juegos), and `Pieza3.jpg` (sillón azul).
const List<StorySceneData> piezaStoryScenes = [
  // ===========================================================================
  // ESCENA 1 (Salón de juegos con alfombra de colores y silla - Pieza1.jpg)
  // Florecita se frustra porque falta la pieza de la cabeza del león y Pablito intenta animarla
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Pieza/Pieza1.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: PiezaPoseAtlas.pablitoStopWaitBothHands,
        normalizedPosition: Offset(0.32, 0.67),
        scale: 0.95,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡Espera, Florecita! Todavía podemos encontrar la pieza del león.',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: PiezaPoseAtlas.florecitaArmsUpFrustratedYelling,
        normalizedPosition: Offset(0.66, 0.67),
        scale: 0.94,
        initialEmotion: 'sad',
        spokenPhrase:
            '¡Me desespera mucho no encontrar la pieza de la cabeza del león!',
        voicePitch: 1.28,
      ),
    ],
    beats: [
      // Diálogo Pablito 1
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Espera, Florecita, no tires todo! Ahorita aparece la pieza que falta. Seguro se cayó debajo de la alfombra o de la silla.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': PiezaPoseAtlas.pablitoStopWaitBothHands,
          'florecita': PiezaPoseAtlas.florecitaArmsUpFrustratedYelling,
        },
      ),
      // Diálogo Pablito 2
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'No desarmes lo que ya armamos juntos. ¡Nos costó muchísimo trabajo construir toda esta selva de animales!',
        pitch: 1.15,
        rate: 0.45,
        poseChanges: {
          'pablito': PiezaPoseAtlas.pablitoConcernedHandsChest,
          'florecita': PiezaPoseAtlas.florecitaArmsUpFrustratedYelling,
        },
      ),
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡No, ya no sirve de nada todo este trabajo! ¡El rompecabezas está arruinado si no tiene la cabeza del león principal!',
        pitch: 1.32,
        rate: 0.46,
        poseChanges: {
          'florecita': PiezaPoseAtlas.florecitaArmsUpFrustratedYelling,
          'pablito': PiezaPoseAtlas.pablitoBendingLookingDown,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Lo odio! ¡Ya no quiero jugar a esto nunca más! ¡Quiero guardar todas las piezas en la caja ahora mismo!',
        pitch: 1.30,
        rate: 0.46,
        poseChanges: {
          'florecita': PiezaPoseAtlas.florecitaSadHoldingPuzzleBox,
          'pablito': PiezaPoseAtlas.pablitoConcernedHandsChest,
        },
      ),
      // Diálogo Pablito 3
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Pero, Florecita, todavía podemos encontrarla. ¡Mira cuánto hemos avanzado! No tenemos que rendirnos tan rápido.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': PiezaPoseAtlas.pablitoPointingEncouraging,
          'florecita': PiezaPoseAtlas.florecitaSadHoldingPuzzleBox,
        },
      ),
      // Diálogo Florecita 3
      VoiceBeat(
        speakerId: 'florecita',
        text: '¡No quiero esperar! ¡Quería terminarlo hoy y ahora ya no puedo!',
        pitch: 1.30,
        rate: 0.46,
        poseChanges: {
          'florecita': PiezaPoseAtlas.florecitaArmsCrossedFrowning,
          'pablito': PiezaPoseAtlas.pablitoConcernedHandsChest,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.48, 0.82),
        spokenSound: '¡En la alfombra de colores construimos el rompecabezas de la selva!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.50, 0.30),
        spokenSound: '¡Con paciencia podemos encontrar la pieza que falta!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2 (Fondo 2: Mesa de juegos - Pieza2.jpg)
  // Naranjito y Pablito ayudan a Florecita a identificar su emoción y respirar como un globo
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Pieza/Pieza2.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: PiezaPoseAtlas.pablitoConcernedHandsChest,
        normalizedPosition: Offset(0.22, 0.68),
        scale: 0.94,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡Respirar profundo nos ayuda a desinflarnos despacito como un globo!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: PiezaPoseAtlas.naranjitoConcernedExplaining,
        normalizedPosition: Offset(0.50, 0.56),
        scale: 0.65,
        initialEmotion: 'appear',
        spokenPhrase:
            '¡Toma aire lentamente por la nariz y suéltalo despacito por la boca!',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: PiezaPoseAtlas.florecitaHandOnChestKnot,
        normalizedPosition: Offset(0.76, 0.67),
        scale: 0.94,
        initialEmotion: 'sad',
        spokenPhrase: '¡Qué alivio! Respirar profundo me hace sentir más tranquila.',
        voicePitch: 1.28,
      ),
    ],
    beats: [
      // Diálogo Naranjito 1 (Fondo 2: Mesa de juegos)
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'A veces, cuando las cosas no salen como queremos, sentimos un nudo enorme y caliente en el pecho. Es una sensación que puede hacernos querer gritar, llorar o aventar las cosas.',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': PiezaPoseAtlas.naranjitoConcernedExplaining,
          'florecita': PiezaPoseAtlas.florecitaHandOnChestKnot,
          'pablito': PiezaPoseAtlas.pablitoConcernedHandsChest,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Florecita, ¿por qué no intentamos descubrir qué estás sintiendo antes de tirar todas las piezas que construiste con tanto esfuerzo?',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': PiezaPoseAtlas.naranjitoWarmHandOnHeart,
          'florecita': PiezaPoseAtlas.florecitaHandOnChestKnot,
        },
      ),
      // Diálogo Florecita 4
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Porque siento que quiero romper algo y aventarlo lejos! Me desespera muchísimo no encontrar la pieza. ¡Yo quería ver el dibujo completo hoy!',
        pitch: 1.31,
        rate: 0.46,
        poseChanges: {
          'florecita': PiezaPoseAtlas.florecitaAngryClenchedFists,
          'naranjito': PiezaPoseAtlas.naranjitoConcernedExplaining,
        },
      ),
      // Diálogo Naranjito 3
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Entiendo, Florecita. A veces sentimos tantas cosas al mismo tiempo que parece que vamos a explotar. Pero primero debemos descubrir qué emoción estamos sintiendo.',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': PiezaPoseAtlas.naranjitoWarmHandOnHeart,
          'florecita': PiezaPoseAtlas.florecitaHandOnChestKnot,
        },
      ),
      // Diálogo Naranjito 4
      VoiceBeat(
        speakerId: 'naranjito',
        text: '¿Estás enojada, triste o tal vez un poquito de las dos?',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': PiezaPoseAtlas.naranjitoAskingEmpathetic,
          'florecita': PiezaPoseAtlas.florecitaTearfulHandsClasped,
        },
      ),
      // Diálogo Florecita 5
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Creo que estoy muy triste y enojada porque quería terminarlo hoy para enseñárselo a mi mamá.',
        pitch: 1.24,
        rate: 0.44,
        poseChanges: {
          'florecita': PiezaPoseAtlas.florecitaTearfulHandsClasped,
          'naranjito': PiezaPoseAtlas.naranjitoWarmHandOnHeart,
          'pablito': PiezaPoseAtlas.pablitoWarmStandingSmile,
        },
      ),
      // Diálogo Pablito 4
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Yo sé qué podemos hacer! Cuando me siento así, mi mamá me dice que soy como un globo rojo a punto de explotar. Entonces me enseña a respirar muy profundo para desinflarme despacito.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': PiezaPoseAtlas.pablitoIdeaFingerUp,
          'naranjito': PiezaPoseAtlas.naranjitoHappyThumbsUp,
          'florecita': PiezaPoseAtlas.florecitaHandOnChestKnot,
        },
      ),
      // Diálogo Naranjito 5
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Qué buena idea, Pablito! Florecita, vamos a intentarlo. Toma aire lentamente por la nariz y suéltalo despacito por la boca. ¡Una vez más!',
        pitch: 1.38,
        rate: 0.44,
        poseChanges: {
          'naranjito': PiezaPoseAtlas.naranjitoDeepBreathingEyesClosed,
          'pablito': PiezaPoseAtlas.pablitoDeepBreathingArmsOpen,
          'florecita': PiezaPoseAtlas.florecitaDeepBreathingCalm,
        },
      ),
      // Diálogo Florecita 6
      VoiceBeat(
        speakerId: 'florecita',
        text: '¡Qué alivio! Creo que ya me siento un poquito más tranquila.',
        pitch: 1.26,
        rate: 0.45,
        poseChanges: {
          'florecita': PiezaPoseAtlas.florecitaDeepBreathingCalm,
          'naranjito': PiezaPoseAtlas.naranjitoHappyThumbsUp,
          'pablito': PiezaPoseAtlas.pablitoWarmStandingSmile,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'party_balloon',
        normalizedPosition: Offset(0.28, 0.28),
        spokenSound:
            '¡Respiramos profundo por la nariz y nos desinflamos despacito como el globo!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.64, 0.28),
        spokenSound: '¡Respirar despacio devuelve la calma a nuestro corazón!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3 (Salón con el sillón azul - Pieza3.jpg)
  // Florecita se disculpa y deciden buscar juntos debajo del sillón azul con tranquilidad
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Pieza/Pieza3.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: PiezaPoseAtlas.pablitoSpeakingCalmOpenHand,
        normalizedPosition: Offset(0.24, 0.68),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Vamos a buscar juntos la pieza debajo del sillón azul!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: PiezaPoseAtlas.florecitaApologeticHandsClasped,
        normalizedPosition: Offset(0.52, 0.67),
        scale: 0.94,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Si no encontramos la cabeza del león hoy, podemos seguir buscando mañana!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: PiezaPoseAtlas.naranjitoWarmHandOnHeart,
        normalizedPosition: Offset(0.78, 0.56),
        scale: 0.66,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Cuando sientas que vas a explotar, haz una pausa y respira con tranquilidad!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Pablito 5
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¿Ves? Está bien estar triste o enojada cuando algo no sale como queremos. A todos nos pasa. Lo importante es aprender a calmarnos antes de hacer algo de lo que podamos arrepentirnos.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': PiezaPoseAtlas.pablitoSpeakingCalmOpenHand,
          'florecita': PiezaPoseAtlas.florecitaApologeticHandsClasped,
          'naranjito': PiezaPoseAtlas.naranjitoWarmHandOnHeart,
        },
      ),
      // Diálogo Florecita 7
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Tienen razón. Perdón por querer tirar todas las piezas. Me esforcé mucho y no quería que nuestro trabajo se arruinara.',
        pitch: 1.26,
        rate: 0.45,
        poseChanges: {
          'florecita': PiezaPoseAtlas.florecitaApologeticHandsClasped,
          'pablito': PiezaPoseAtlas.pablitoWarmStandingSmile,
          'naranjito': PiezaPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Pablito 6
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡No te preocupes! ¿Qué tal si recogemos las piezas y buscamos juntos debajo del sillón azul?',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': PiezaPoseAtlas.pablitoPointingToBlueSofa,
          'florecita': PiezaPoseAtlas.florecitaDeterminedHappyFist,
        },
      ),
      // Diálogo Florecita 8
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Sí! ¡Y si no encontramos la cabeza del león hoy, podemos seguir buscando mañana!',
        pitch: 1.29,
        rate: 0.45,
        poseChanges: {
          'florecita': PiezaPoseAtlas.florecitaDeterminedHappyFist,
          'pablito': PiezaPoseAtlas.pablitoPointingToBlueSofa,
          'naranjito': PiezaPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Naranjito 6
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Así se hace! Recuerden que todas las emociones son importantes. Cuando sientan que están a punto de explotar, hagan una pausa, respiren y busquen una solución con tranquilidad.',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': PiezaPoseAtlas.naranjitoArmsOpenBigSmile,
          'florecita': PiezaPoseAtlas.florecitaDeterminedHappyFist,
          'pablito': PiezaPoseAtlas.pablitoWarmStandingSmile,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'cozy_cushion',
        normalizedPosition: Offset(0.84, 0.72),
        spokenSound: '¡Vamos a buscar debajo del sillón azul y los cojines!',
      ),
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.54, 0.26),
        spokenSound:
            '¡Una estrella brillante por hacer una pausa, respirar y buscar una solución!',
      ),
    ],
  ),
];

/// Story 8 ("El carrito rojo de bomberos") — structured into 3 scenes
/// using `Carrito.jpg` (salón con alfombra de pista de ciudad y estación de bomberos).
const List<StorySceneData> carritoStoryScenes = [
  // ===========================================================================
  // ESCENA 1 (Pablito quiere quitarle el carrito rojo a Florecita - Carrito.jpg)
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Carrito/Carrito.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CarritoPoseAtlas.pablitoReachingGrabbingCar,
        normalizedPosition: Offset(0.32, 0.66),
        scale: 0.96,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡Yo quiero jugar con el carrito rojo de bomberos en la pista!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CarritoPoseAtlas.florecitaHoldingCarHappy,
        normalizedPosition: Offset(0.66, 0.66),
        scale: 0.95,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡Solo me falta una vuelta más para llegar a la estación!',
        voicePitch: 1.28,
      ),
    ],
    beats: [
      // Diálogo Pablito 1
      VoiceBeat(
        speakerId: 'pablito',
        text: '¡Yo quiero el carrito rojo ahora mismo! ¡Dámelo!',
        pitch: 1.18,
        rate: 0.46,
        poseChanges: {
          'pablito': CarritoPoseAtlas.pablitoReachingGrabbingCar,
          'florecita': CarritoPoseAtlas.florecitaHuggingCarProtective,
        },
      ),
      // Diálogo Pablito 2
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Tú ya jugaste muchísimo tiempo con él en la pista. ¡Ahora me toca a mí ser el jefe de los bomberos que apaga los incendios! ¡Es mi turno!',
        pitch: 1.17,
        rate: 0.46,
        poseChanges: {
          'pablito': CarritoPoseAtlas.pablitoAngryClenchedFist,
          'florecita': CarritoPoseAtlas.florecitaHuggingCarProtective,
        },
      ),
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Espera, Pablito! Todavía no termino de llevar a los pasajeros a la estación. ¡Solo me falta una vuelta más!',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CarritoPoseAtlas.florecitaStopWaitHand,
          'pablito': CarritoPoseAtlas.pablitoReachingGrabbingCar,
        },
      ),
      // Diálogo Pablito 3
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡No quiero esperar! ¡Dámelo! ¡Es mi carrito favorito de todo el salón!',
        pitch: 1.19,
        rate: 0.46,
        poseChanges: {
          'pablito': CarritoPoseAtlas.pablitoAngryClenchedFist,
          'florecita': CarritoPoseAtlas.florecitaHandsOnHipsFrowning,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.38, 0.34),
        spokenSound: '¡La estación de bomberos espera al carrito rojo en la ciudad!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.64, 0.30),
        spokenSound: '¡Pedir las cosas por favor es mucho mejor que arrebatar!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2 (Naranjito detiene a Pablito y le recuerda para qué sirven las manos - Carrito.jpg)
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Carrito/Carrito.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CarritoPoseAtlas.pablitoLookingAtHands,
        normalizedPosition: Offset(0.24, 0.67),
        scale: 0.95,
        initialEmotion: 'sad',
        spokenPhrase:
            '¡Mis manos son para saludar, abrazar, construir y ayudar!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CarritoPoseAtlas.naranjitoStopWaitHand,
        normalizedPosition: Offset(0.50, 0.55),
        scale: 0.65,
        initialEmotion: 'appear',
        spokenPhrase:
            '¡Usamos nuestras palabras amables para pedir lo que queremos!',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CarritoPoseAtlas.florecitaHuggingCarProtective,
        normalizedPosition: Offset(0.76, 0.67),
        scale: 0.94,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡Podemos compartir el carrito rojo tomando turnos!',
        voicePitch: 1.28,
      ),
    ],
    beats: [
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Pablito, detente un momento! Mira tus manos, estás jalando el carrito con mucha fuerza. ¿Crees que esa es una buena manera de pedirlo?',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CarritoPoseAtlas.naranjitoPointingFingersTogether,
          'pablito': CarritoPoseAtlas.pablitoLookingAtHands,
          'florecita': CarritoPoseAtlas.florecitaHuggingCarProtective,
        },
      ),
      // Diálogo Pablito 4
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Es que lo quiero jugar ya mismo. ¡No quiero esperar ni un minuto más! Florecita lo tiene desde hace muchísimo tiempo.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': CarritoPoseAtlas.pablitoAngryClenchedFist,
          'naranjito': CarritoPoseAtlas.naranjitoPointingFingersTogether,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Entiendo que tengas muchas ganas de jugar, pero todos tenemos derecho a disfrutar de los juguetes. ¿Qué tal si usamos nuestras palabras en lugar de nuestras manos para pedir lo que queremos?',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CarritoPoseAtlas.naranjitoAskingOneHandOpen,
          'pablito': CarritoPoseAtlas.pablitoLookingAtHands,
          'florecita': CarritoPoseAtlas.florecitaStandingListening,
        },
      ),
      // Diálogo Naranjito 3
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Recuerda que nuestras manos son maravillosas para saludar, abrazar, construir y ayudar. ¡Nunca debemos usarlas para quitar las cosas a la fuerza!',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CarritoPoseAtlas.naranjitoShowingBothHandsOpen,
          'pablito': CarritoPoseAtlas.pablitoApologeticHandBehindHead,
          'florecita': CarritoPoseAtlas.florecitaStandingListening,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.50, 0.28),
        spokenSound:
            '¡Nuestras manos son maravillosas para saludar, abrazar, construir y ayudar!',
      ),
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.26, 0.30),
        spokenSound: '¡Usamos palabras amables para pedir prestado un juguete!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3 (Pablito pide perdón y por favor, y construyen juntos esperando su turno - Carrito.jpg)
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Carrito/Carrito.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CarritoPoseAtlas.pablitoApologeticHandBehindHead,
        normalizedPosition: Offset(0.24, 0.67),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Mientras espero mi turno, preparo la pista con los bloques!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CarritoPoseAtlas.naranjitoShowingBothHandsOpen,
        normalizedPosition: Offset(0.50, 0.55),
        scale: 0.65,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Compartir nuestros juguetes y respetar los turnos nos hace felices a todos!',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CarritoPoseAtlas.florecitaStandingListening,
        normalizedPosition: Offset(0.76, 0.67),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Aquí tienes el carrito rojo de bomberos para que seas el nuevo chofer!',
        voicePitch: 1.28,
      ),
    ],
    beats: [
      // Diálogo Pablito 5
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Tienes razón, Naranjito. Me equivoqué. Perdón por jalarlo tan fuerte, Florecita.',
        pitch: 1.14,
        rate: 0.44,
        poseChanges: {
          'pablito': CarritoPoseAtlas.pablitoApologeticHandBehindHead,
          'florecita': CarritoPoseAtlas.florecitaStandingListening,
          'naranjito': CarritoPoseAtlas.naranjitoShowingBothHandsOpen,
        },
      ),
      // Diálogo Pablito 6
      VoiceBeat(
        speakerId: 'pablito',
        text:
            'Me desesperé porque pensé que no me lo prestarías. ¿Por favor, me prestas el carrito cuando termines de dar esa vuelta por la ciudad?',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': CarritoPoseAtlas.pablitoPleaseHandsTogether,
          'florecita': CarritoPoseAtlas.florecitaPointingStationSmiling,
          'naranjito': CarritoPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Sí, claro! Cuando el camión llegue a la estación de bomberos y se estacione, te lo doy para que tú seas el nuevo chofer.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CarritoPoseAtlas.florecitaSharingCarBothHands,
          'pablito': CarritoPoseAtlas.pablitoWaitingPatientlyHandsBack,
          'naranjito': CarritoPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Pablito 7
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Muchas gracias! Mientras espero, puedo preparar la pista para nuestra siguiente emergencia.',
        pitch: 1.17,
        rate: 0.45,
        poseChanges: {
          'pablito': CarritoPoseAtlas.pablitoKneelingBuildingTrack,
          'florecita': CarritoPoseAtlas.florecitaHoldingCarHappy,
          'naranjito': CarritoPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Naranjito 4
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Muy bien, Pablito! A veces esperar puede ser difícil, pero pedir las cosas con respeto y compartir nuestros juguetes hace que todos podamos divertirnos. ¡Recuerden que cada quien tiene su turno!',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CarritoPoseAtlas.naranjitoArmsOpenBigSmile,
          'pablito': CarritoPoseAtlas.pablitoHappyThumbsUp,
          'florecita': CarritoPoseAtlas.florecitaSharingCarBothHands,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.50, 0.26),
        spokenSound:
            '¡Una estrella brillante por pedir las cosas por favor y esperar nuestro turno!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.76, 0.30),
        spokenSound: '¡Compartir con nuestros amigos multiplica la diversión!',
      ),
    ],
  ),
];

/// Story 9 ("El monstruo de las cosquillas") — structured into 3 scenes
/// using `Cosquillas.jpg` (patio con mesas bajo la sombrilla multicolor y juegos).
const List<StorySceneData> cosquillasStoryScenes = [
  // ===========================================================================
  // ESCENA 1 (El compañero le hace cosquillas a Florecita y Naranjito le recuerda que su cuerpo es suyo - Cosquillas.jpg)
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Cosquillas/Cosquillas.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'companero',
        initialPose: CosquillasPoseAtlas.companeroTickleHandsUp,
        normalizedPosition: Offset(0.28, 0.67),
        scale: 0.96,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡Aquí viene el monstruo de las cosquillas!',
        voicePitch: 1.08,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CosquillasPoseAtlas.florecitaSittingWithSandwich,
        normalizedPosition: Offset(0.58, 0.67),
        scale: 0.95,
        initialEmotion: 'sad',
        spokenPhrase:
            '¡Mi cuerpo es mío y tengo derecho a decir que no quiero cosquillas!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CosquillasPoseAtlas.naranjitoWarmHandOnHeart,
        normalizedPosition: Offset(0.82, 0.54),
        scale: 0.65,
        initialEmotion: 'appear',
        spokenPhrase:
            '¡Tienes una voz fuerte y valiente para decir qué te gusta y qué te incomoda!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Compañero 1
      VoiceBeat(
        speakerId: 'companero',
        text:
            '¡Cosquillas, cosquillas del gran monstruo come-niños! ¡No te puedes escapar de mí, te voy a hacer reír mucho!',
        pitch: 1.10,
        rate: 0.46,
        poseChanges: {
          'companero': CosquillasPoseAtlas.companeroTickleHandsUp,
          'florecita': CosquillasPoseAtlas.florecitaSittingWithSandwich,
        },
      ),
      // Diálogo Compañero 2
      VoiceBeat(
        speakerId: 'companero',
        text:
            '¡Aquí viene el monstruo de las cosquillas! ¡Prepárate, Florecita, que allá voy!',
        pitch: 1.08,
        rate: 0.46,
        poseChanges: {
          'companero': CosquillasPoseAtlas.companeroTickleMonsterCrouch,
          'florecita': CosquillasPoseAtlas.florecitaLaughingUncomfortableStop,
        },
      ),
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Ay, me da mucha risa, pero ya basta! ¡No quiero más cosquillas! ¡Déjame tranquila!',
        pitch: 1.32,
        rate: 0.46,
        poseChanges: {
          'florecita': CosquillasPoseAtlas.florecitaLaughingUncomfortableStop,
          'companero': CosquillasPoseAtlas.companeroTickleMonsterCrouch,
        },
      ),
      // Diálogo Compañero 3
      VoiceBeat(
        speakerId: 'companero',
        text:
            '¡Pero si te estás riendo! ¡Eso significa que te está gustando! ¡Una cosquilla más!',
        pitch: 1.10,
        rate: 0.46,
        poseChanges: {
          'companero': CosquillasPoseAtlas.companeroTickleHandsUp,
          'florecita': CosquillasPoseAtlas.florecitaStopHandFirm,
        },
      ),
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Recuerda algo muy importante, Florecita: tu cuerpo es tuyo y nadie debe tocarte si tú no quieres.',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CosquillasPoseAtlas.naranjitoWarmHandOnHeart,
          'florecita': CosquillasPoseAtlas.florecitaThinkingChin,
        },
      ),
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Aunque alguien diga que solo está jugando, tienes derecho a decir que no. ¿Recuerdas que tienes una voz fuerte y valiente para decir qué te gusta y qué te incomoda?',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CosquillasPoseAtlas.naranjitoVoiceCuppedHands,
          'florecita': CosquillasPoseAtlas.florecitaConfidentHandOnChest,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'magic_bubble',
        normalizedPosition: Offset(0.58, 0.32),
        spokenSound: '¡Nuestro cuerpo nos pertenece y nadie debe tocarnos sin permiso!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.80, 0.28),
        spokenSound: '¡Tenemos una voz fuerte y valiente para decir NO cuando algo nos incomoda!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2 (Pablito apoya a Florecita y ella pone un límite firme y claro - Cosquillas.jpg)
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Cosquillas/Cosquillas.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CosquillasPoseAtlas.pablitoStopWaitHand,
        normalizedPosition: Offset(0.18, 0.68),
        scale: 0.94,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Déjala comer su sándwich tranquila, debemos respetar a nuestros amigos!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'companero',
        initialPose: CosquillasPoseAtlas.companeroShruggingBothHands,
        normalizedPosition: Offset(0.42, 0.67),
        scale: 0.95,
        initialEmotion: 'talk',
        spokenPhrase:
            'Perdón, Florecita, no sabía que las cosquillas te molestaban tanto.',
        voicePitch: 1.08,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CosquillasPoseAtlas.florecitaStopHandFirm,
        normalizedPosition: Offset(0.66, 0.67),
        scale: 0.95,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡No me gusta que me hagas cosquillas sin preguntarme!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CosquillasPoseAtlas.naranjitoFirmFingerUp,
        normalizedPosition: Offset(0.86, 0.54),
        scale: 0.63,
        initialEmotion: 'talk',
        spokenPhrase:
            '¡Aunque alguien sea nuestro amigo, siempre debe respetar nuestros límites!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Pablito 1
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡Oye, espera! Déjala comer su sándwich tranquila. ¡Mira su carita! No parece que se esté divirtiendo con tus cosquillas.',
        pitch: 1.16,
        rate: 0.45,
        poseChanges: {
          'pablito': CosquillasPoseAtlas.pablitoPointingAtFlorecitaFace,
          'companero': CosquillasPoseAtlas.companeroShruggingBothHands,
          'florecita': CosquillasPoseAtlas.florecitaStopHandFirm,
        },
      ),
      // Diálogo Compañero 4
      VoiceBeat(
        speakerId: 'companero',
        text:
            '¡Pero yo solo quería hacerla reír! ¡No pensé que se molestaría tanto!',
        pitch: 1.09,
        rate: 0.45,
        poseChanges: {
          'companero': CosquillasPoseAtlas.companeroShruggingBothHands,
          'pablito': CosquillasPoseAtlas.pablitoArmsCrossedSerious,
        },
      ),
      // Diálogo Florecita 2
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Basta! ¡Escúchame bien! No me gusta que me hagas cosquillas. ¡Me molesta muchísimo que me toques así sin preguntarme! ¡Quiero comer tranquila!',
        pitch: 1.29,
        rate: 0.45,
        poseChanges: {
          'florecita': CosquillasPoseAtlas.florecitaAngryHandsOnHips,
          'companero': CosquillasPoseAtlas.companeroApologeticLookingDown,
          'naranjito': CosquillasPoseAtlas.naranjitoStopHandFirm,
        },
      ),
      // Diálogo Naranjito 3
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Muy bien, Florecita! Decir lo que no nos gusta es importante. Y recuerda que, aunque alguien sea nuestro amigo, siempre debe respetar nuestros límites.',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CosquillasPoseAtlas.naranjitoHappyThumbsUp,
          'florecita': CosquillasPoseAtlas.florecitaConfidentHandOnChest,
          'pablito': CosquillasPoseAtlas.pablitoListeningHandsBack,
        },
      ),
      // Diálogo Compañero 5
      VoiceBeat(
        speakerId: 'companero',
        text:
            'Disculpa, Florecita. De verdad creí que estábamos jugando y que te divertías porque te estabas riendo. No sabía que te molestaba tanto.',
        pitch: 1.06,
        rate: 0.44,
        poseChanges: {
          'companero': CosquillasPoseAtlas.companeroApologeticLookingDown,
          'florecita': CosquillasPoseAtlas.florecitaExplainingBothHands,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.66, 0.28),
        spokenSound:
            '¡Qué valiente fue Florecita al decir con voz firme lo que no le gusta!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.28, 0.30),
        spokenSound: '¡Un buen amigo escucha y respeta cuando alguien dice basta!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3 (El compañero promete preguntar primero, Florecita come tranquila y eligen un juego para todos - Cosquillas.jpg)
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Cosquillas/Cosquillas.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: CosquillasPoseAtlas.pablitoListeningHandsBack,
        normalizedPosition: Offset(0.18, 0.68),
        scale: 0.94,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Vamos a elegir un juego en el patio que nos guste a todos!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'companero',
        initialPose: CosquillasPoseAtlas.companeroThinkingChin,
        normalizedPosition: Offset(0.41, 0.67),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Prometo preguntar siempre antes de jugar y respetar tus límites!',
        voicePitch: 1.08,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: CosquillasPoseAtlas.florecitaExplainingBothHands,
        normalizedPosition: Offset(0.65, 0.67),
        scale: 0.95,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Primero termino mi sándwich tranquila y después jugamos juntos!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: CosquillasPoseAtlas.naranjitoFirmFingerUp,
        normalizedPosition: Offset(0.86, 0.54),
        scale: 0.63,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Su cuerpo les pertenece y siempre pueden decir NO cuando algo les incomoda!',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Florecita 3
      VoiceBeat(
        speakerId: 'florecita',
        text:
            'Está bien que quieras jugar conmigo, pero primero debes preguntarme si quiero. ¡No todos disfrutamos de los mismos juegos!',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CosquillasPoseAtlas.florecitaExplainingBothHands,
          'companero': CosquillasPoseAtlas.companeroThinkingChin,
          'naranjito': CosquillasPoseAtlas.naranjitoFirmFingerUp,
        },
      ),
      // Diálogo Compañero 6
      VoiceBeat(
        speakerId: 'companero',
        text:
            'Tienes razón. Te prometo que no volveré a hacerte cosquillas si no quieres. ¿Podemos seguir jugando a otra cosa?',
        pitch: 1.08,
        rate: 0.45,
        poseChanges: {
          'companero': CosquillasPoseAtlas.companeroHandOnHeartPromise,
          'florecita': CosquillasPoseAtlas.florecitaConfidentHandOnChest,
          'pablito': CosquillasPoseAtlas.pablitoListeningHandsBack,
        },
      ),
      // Diálogo Florecita 4
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Claro! Pero primero quiero terminar mi sándwich. Después podemos jugar juntos en el patio.',
        pitch: 1.28,
        rate: 0.45,
        poseChanges: {
          'florecita': CosquillasPoseAtlas.florecitaEatingSandwichHappy,
          'companero': CosquillasPoseAtlas.companeroInvitingOpenHand,
          'naranjito': CosquillasPoseAtlas.naranjitoHappyThumbsUp,
        },
      ),
      // Diálogo Pablito 2
      VoiceBeat(
        speakerId: 'pablito',
        text: '¡Y esta vez podemos elegir un juego que nos guste a todos!',
        pitch: 1.17,
        rate: 0.45,
        poseChanges: {
          'pablito': CosquillasPoseAtlas.pablitoWavingHappy,
          'florecita': CosquillasPoseAtlas.florecitaPointingPatioSmiling,
          'companero': CosquillasPoseAtlas.companeroStandingPoliteHandsBack,
        },
      ),
      // Diálogo Naranjito 4
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Súper! Recuerden: su cuerpo les pertenece, pueden decir NO cuando algo les incomoda y siempre pueden pedir ayuda a un adulto de confianza. ¡Nadie debe obligarlos a aceptar un contacto que no desean!',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': CosquillasPoseAtlas.naranjitoArmsOpenBigSmile,
          'pablito': CosquillasPoseAtlas.pablitoJumpingJoy,
          'florecita': CosquillasPoseAtlas.florecitaPointingPatioSmiling,
          'companero': CosquillasPoseAtlas.companeroInvitingOpenHand,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.52, 0.26),
        spokenSound:
            '¡Una estrella brillante por cuidar nuestro cuerpo y decir NO cuando algo nos incomoda!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.76, 0.28),
        spokenSound:
            '¡Jugar preguntando primero y respetando a todos es mucho más divertido!',
      ),
    ],
  ),
];

/// Complete 10th Story ("El desconocido en el parque") structured into 3 linear scenes
const List<StorySceneData> parqueStoryScenes = [
  // ===========================================================================
  // ESCENA 1 (Un desconocido le ofrece dulces y juguetes en su coche detrás de los árboles; Naranjito detiene a Pablito - Parque1.jpg)
  // ===========================================================================
  StorySceneData(
    index: 0,
    backgroundAsset: 'background/stories/Parque/Parque1.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'desconocido',
        initialPose: ParquePoseAtlas.desconocidoWavingHello,
        normalizedPosition: Offset(0.26, 0.65),
        scale: 1.06,
        initialEmotion: 'walk',
        spokenPhrase:
            'Tengo unos juguetes nuevos increíbles y unos dulces de chocolate en mi coche.',
        voicePitch: 0.90,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: ParquePoseAtlas.pablitoPlayingWithToyCars,
        normalizedPosition: Offset(0.62, 0.72),
        scale: 0.90,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡No conozco a este señor! Nunca lo había visto en el parque.',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: ParquePoseAtlas.naranjitoStopHandWait,
        normalizedPosition: Offset(0.84, 0.52),
        scale: 0.64,
        initialEmotion: 'appear',
        spokenPhrase:
            '¡Un momento, Pablito! No des ni un paso más. ¿Conoces a esta persona?',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Señor Desconocido 1
      VoiceBeat(
        speakerId: 'desconocido',
        text:
            '¡Hola, amiguito! Veo que estás jugando muy divertido. Tengo unos juguetes nuevos increíbles y unos dulces de chocolate muy ricos. ¿Te gustan los dulces?',
        pitch: 0.92,
        rate: 0.45,
        poseChanges: {
          'desconocido': ParquePoseAtlas.desconocidoOfferingChocolate,
          'pablito': ParquePoseAtlas.pablitoSurprisedListening,
        },
        positionChanges: {
          'pablito': Offset(0.62, 0.68),
        },
      ),
      // Diálogo Pablito 1
      VoiceBeat(
        speakerId: 'pablito',
        text: '¡Sí! ¡Me encantan los chocolates y los carritos de juguete!',
        pitch: 1.16,
        rate: 0.46,
        poseChanges: {
          'pablito': ParquePoseAtlas.pablitoExcitedHandsByCheeks,
          'desconocido': ParquePoseAtlas.desconocidoInvitingHandOnChest,
        },
      ),
      // Diálogo Señor Desconocido 2
      VoiceBeat(
        speakerId: 'desconocido',
        text:
            '¡Qué bien! Pues tengo muchos regalos para ti, pero los dejé guardados en mi coche, allá atrás de aquellos árboles. ¿Quieres venir conmigo rapidito? ¡Puedes escoger el juguete que más te guste y llevártelo a casa!',
        pitch: 0.92,
        rate: 0.45,
        poseChanges: {
          'desconocido': ParquePoseAtlas.desconocidoPointingToCarBehindTrees,
          'pablito': ParquePoseAtlas.pablitoSurprisedListening,
        },
      ),
      // Diálogo Pablito 2
      VoiceBeat(
        speakerId: 'pablito',
        text: '¿De verdad? ¡Qué bonitos regalos! Pero... ¿por qué están tan lejos?',
        pitch: 1.13,
        rate: 0.44,
        poseChanges: {
          'pablito': ParquePoseAtlas.pablitoDoubtfulHandOnChin,
          'naranjito': ParquePoseAtlas.naranjitoWorriedWarning,
        },
      ),
      // Diálogo Naranjito 1
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Un momento, Pablito! No des ni un paso más. Recuerda lo que hemos aprendido. ¿Conoces a esta persona? ¿Sabes quién es y por qué quiere llevarte a un lugar donde no hay nadie?',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': ParquePoseAtlas.naranjitoThinkingQuestion,
          'pablito': ParquePoseAtlas.pablitoDoubtfulHandOnChin,
        },
      ),
      // Diálogo Pablito 3
      VoiceBeat(
        speakerId: 'pablito',
        text: 'No, no lo conozco en absoluto. Nunca lo había visto en este parque.',
        pitch: 1.12,
        rate: 0.44,
        poseChanges: {
          'pablito': ParquePoseAtlas.pablitoWorriedArmsCrossed,
          'naranjito': ParquePoseAtlas.naranjitoStopHandWait,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.50, 0.25),
        spokenSound:
            '¡Detente y piensa! Si no conoces a una persona, nunca vayas con ella a otro lugar.',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 2 (Pablito dice NO con firmeza al desconocido y Florecita lo llama para ir con su mamá - Parque1.jpg)
  // ===========================================================================
  StorySceneData(
    index: 1,
    backgroundAsset: 'background/stories/Parque/Parque1.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'desconocido',
        initialPose: ParquePoseAtlas.desconocidoInvitingHandOnChest,
        normalizedPosition: Offset(0.20, 0.65),
        scale: 1.04,
        initialEmotion: 'whisper',
        spokenPhrase: 'Solo será un momentito en mi coche allá atrás.',
        voicePitch: 0.90,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: ParquePoseAtlas.pablitoWorriedArmsCrossed,
        normalizedPosition: Offset(0.48, 0.68),
        scale: 0.94,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡No, muchas gracias! ¡No debo irme con personas desconocidas!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: ParquePoseAtlas.naranjitoWiseFingerUpWarning,
        normalizedPosition: Offset(0.68, 0.50),
        scale: 0.63,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Nunca te alejes con alguien que no sea de confianza, aunque te ofrezca dulces o juguetes!',
        voicePitch: 1.38,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: ParquePoseAtlas.florecitaWavingComeHere,
        normalizedPosition: Offset(0.86, 0.67),
        scale: 0.93,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Pablito, ven rápido! ¡Tu mamá nos está llamando para tomar agua de limón!',
        voicePitch: 1.28,
      ),
    ],
    beats: [
      // Diálogo Naranjito 2
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            'Entonces debes tener mucho cuidado. Nunca te alejes con alguien que no sea de confianza, aunque te ofrezca juguetes, dulces o regalos. ¡Tampoco tienes que aceptar nada para quedar bien con esa persona!',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': ParquePoseAtlas.naranjitoPointingWarning,
          'pablito': ParquePoseAtlas.pablitoFirmArmsCrossed,
        },
      ),
      // Diálogo Señor Desconocido 3
      VoiceBeat(
        speakerId: 'desconocido',
        text:
            '¡Vamos, amiguito! No tengas miedo. Solo será un momentito y después podrás regresar a jugar.',
        pitch: 0.92,
        rate: 0.45,
        poseChanges: {
          'desconocido': ParquePoseAtlas.desconocidoInsistingComeQuickly,
          'naranjito': ParquePoseAtlas.naranjitoStopHandWait,
        },
      ),
      // Diálogo Pablito 4
      VoiceBeat(
        speakerId: 'pablito',
        text:
            '¡No, muchas gracias! Mi mamá me enseñó que no debo irme con personas desconocidas ni aceptar regalos sin preguntarle primero.',
        pitch: 1.17,
        rate: 0.45,
        poseChanges: {
          'pablito': ParquePoseAtlas.pablitoStopHandFirmNo,
          'desconocido': ParquePoseAtlas.desconocidoFoiledDisappointed,
          'naranjito': ParquePoseAtlas.naranjitoThumbsUpProud,
        },
      ),
      // Diálogo Florecita 1
      VoiceBeat(
        speakerId: 'florecita',
        text:
            '¡Pablito! ¡Ven rápido! ¡Tu mamá nos está llamando desde la mesa de madera para tomar agua de limón!',
        pitch: 1.28,
        rate: 0.46,
        poseChanges: {
          'florecita': ParquePoseAtlas.florecitaCallingHandsCupped,
          'pablito': ParquePoseAtlas.pablitoFirmArmsCrossed,
        },
        positionChanges: {
          'florecita': Offset(0.82, 0.67),
        },
      ),
      // Diálogo Pablito 5
      VoiceBeat(
        speakerId: 'pablito',
        text: '¡Ya voy, Florecita! ¡No quiero sus regalos, tengo que ir con mi mamá!',
        pitch: 1.17,
        rate: 0.46,
        poseChanges: {
          'pablito': ParquePoseAtlas.pablitoRunningToMom,
          'florecita': ParquePoseAtlas.florecitaPointingToMom,
          'desconocido': ParquePoseAtlas.desconocidoFoiledDisappointed,
        },
        positionChanges: {
          'pablito': Offset(0.62, 0.68),
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.48, 0.25),
        spokenSound:
            '¡Qué valiente fue Pablito al decir NO muchas gracias y correr hacia donde estaba su mamá!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.78, 0.28),
        spokenSound: '¡Los amigos se cuidan y avisan cuando mamá nos llama!',
      ),
    ],
  ),

  // ===========================================================================
  // ESCENA 3 (Pablito llega con su mamá y Florecita, y decide contarle todo para estar seguro - Parque2.jpg)
  // ===========================================================================
  StorySceneData(
    index: 2,
    backgroundAsset: 'background/stories/Parque/Parque2.jpg',
    characters: [
      CharacterPlacement(
        characterId: 'mama',
        initialPose: ParquePoseAtlas.mamaHoldingLemonadePitcher,
        normalizedPosition: Offset(0.20, 0.63),
        scale: 1.06,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Siempre puedes contarme todo, Pablito! Yo estoy aquí para cuidarte y protegerte.',
        voicePitch: 1.10,
      ),
      CharacterPlacement(
        characterId: 'pablito',
        initialPose: ParquePoseAtlas.pablitoRunningToMom,
        normalizedPosition: Offset(0.45, 0.68),
        scale: 0.94,
        initialEmotion: 'walk',
        spokenPhrase:
            '¡Le conté todo a mi mamá y no acepté regalos de desconocidos!',
        voicePitch: 1.15,
      ),
      CharacterPlacement(
        characterId: 'florecita',
        initialPose: ParquePoseAtlas.florecitaHoldingLemonadeGlass,
        normalizedPosition: Offset(0.68, 0.68),
        scale: 0.94,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Qué rica está el agua de limón aquí seguros junto a tu mamá!',
        voicePitch: 1.28,
      ),
      CharacterPlacement(
        characterId: 'naranjito',
        initialPose: ParquePoseAtlas.naranjitoSpeakingGentleHands,
        normalizedPosition: Offset(0.86, 0.52),
        scale: 0.64,
        initialEmotion: 'happy',
        spokenPhrase:
            '¡Su seguridad siempre es lo más importante! Nunca se vayan con desconocidos.',
        voicePitch: 1.38,
      ),
    ],
    beats: [
      // Diálogo Naranjito 3
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Muy bien, Pablito! Ahora ve con tu mamá y cuéntale lo que acaba de pasar. Si alguna persona que no es de confianza intenta llevarte a otro lugar, busca inmediatamente a un adulto de confianza y nunca te alejes de las personas que te cuidan.',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': ParquePoseAtlas.naranjitoSpeakingGentleHands,
          'mama': ParquePoseAtlas.mamaLeaningListeningCaring,
          'pablito': ParquePoseAtlas.pablitoTellingMomEverything,
        },
        positionChanges: {
          'pablito': Offset(0.42, 0.68),
        },
      ),
      // Diálogo Pablito 6
      VoiceBeat(
        speakerId: 'pablito',
        text: '¡Se lo voy a contar todo! ¡Así mi mamá podrá ayudarme!',
        pitch: 1.17,
        rate: 0.45,
        poseChanges: {
          'pablito': ParquePoseAtlas.pablitoTellingMomEverything,
          'mama': ParquePoseAtlas.mamaConcernedHandOnHeart,
          'florecita': ParquePoseAtlas.florecitaHappyHandsTogether,
          'naranjito': ParquePoseAtlas.naranjitoThumbsUpProud,
        },
      ),
      // Diálogo Naranjito 4
      VoiceBeat(
        speakerId: 'naranjito',
        text:
            '¡Recuerden, pequeños! Nunca se vayan con desconocidos ni acepten regalos sin consultar primero con un adulto de confianza. ¡Su seguridad siempre es lo más importante!',
        pitch: 1.38,
        rate: 0.45,
        poseChanges: {
          'naranjito': ParquePoseAtlas.naranjitoArmsOpenBigSmile,
          'mama': ParquePoseAtlas.mamaOpenArmsProtectiveHug,
          'pablito': ParquePoseAtlas.pablitoTellingMomEverything,
          'florecita': ParquePoseAtlas.florecitaHoldingLemonadeGlass,
        },
      ),
    ],
    props: [
      InteractivePropData(
        type: 'star',
        normalizedPosition: Offset(0.52, 0.25),
        spokenSound:
            '¡Una estrella dorada por avisar inmediatamente a mamá y nunca irse con desconocidos!',
      ),
      InteractivePropData(
        type: 'heart',
        normalizedPosition: Offset(0.28, 0.26),
        spokenSound:
            '¡Los adultos de confianza que nos cuidan siempre nos escuchan y nos protegen!',
      ),
    ],
  ),
];

/// Returns the list of scenes for a given story index:
/// `0` = El crayón rojo
/// `1` = La nube de tormenta
/// `2` = La burbuja personal
/// `3` = El papalote en el árbol
/// `4` = La niña nueva
/// `5` = Juegos seguros en el patio grande
/// `6` = La pieza perdida del rompecabezas
/// `7` = El carrito rojo de bomberos
/// `8` = El monstruo de las cosquillas
/// `9` = El desconocido en el parque
List<StorySceneData> getStoryScenes(int storyIndex) {
  switch (storyIndex) {
    case 9:
      return parqueStoryScenes;
    case 8:
      return cosquillasStoryScenes;
    case 7:
      return carritoStoryScenes;
    case 6:
      return piezaStoryScenes;
    case 5:
      return juegosStoryScenes;
    case 4:
      return companeraStoryScenes;
    case 3:
      return papaloteStoryScenes;
    case 2:
      return burbujaStoryScenes;
    case 1:
      return nubeStoryScenes;
    case 0:
    default:
      return crayonStoryScenes;
  }
}
