// --- Obter Comandos do Jogador ---
leftKey = keyboard_check(vk_left);
rightKey = keyboard_check(vk_right);
jumpKey = keyboard_check(vk_space);
shotKey = keyboard_check_pressed(ord("Z"));

// Atualizar variaveis de estado
grounded = place_meeting(x, y + 5, oSolid);

// --- Movimento Horizontal ---
// Velocidade inicia zerada.
hsp = 0;

// Checa Inputs e altera velocidade
if leftKey {
  hsp = -movespeed;
}

if rightKey {
  hsp = movespeed; 
}

if jumpKey and grounded {
  vsp = -jumpForce;
}

if shotTimer > 0 {
  shotTimer = shotTimer - 1;
}

if shotKey and instance_number(oBullet) < 3 {
  shotTimer = 12;
  var _bullet = instance_create_layer(x + 17 * facing, y - 8, "Instances", oBullet);
  _bullet.hsp = facing * 5;
}

// Atualizar o valor de 'facing'
if hsp != 0 {
  facing = sign(hsp)
}

// Checar colisões horizontalmente
if place_meeting(x + hsp, y, oSolid) {
  hsp = 0; 
}

// Atualiza posição
x = x + hsp;

// --- Movimento Vertical ---
vsp = vsp + grav;
if place_meeting(x, y + vsp, oSolid) {
  vsp = 0;
}

// Atualizar coordenada
y = y + vsp;

// --- Atualização de Sprites ---
sprite_index = sMegamanIdle;
if hsp != 0 {
  sprite_index = sMegamanWalk;
}
if !grounded {
  sprite_index = sMegamanJump;
}

if shotTimer > 0 {
  if !grounded {
    sprite_index = sMegamanJumpShoot; 
  } else {
    if hsp != 0 {
      sprite_index = sMegamanWalkShoot;
    } else {
      sprite_index = sMegamanIdleShoot;
    }
  }
}

// Virar sprite conforme a direção
image_xscale = facing;
