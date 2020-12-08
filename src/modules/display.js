const CELL_SIZE = 9;
const CELL_GUTTER = 2;

const SCREEN_WIDTH = 800;
const SCREEN_HEIGHT = 480;

const colCount = Math.floor(SCREEN_WIDTH / (CELL_SIZE + CELL_GUTTER));
const rowCount = Math.floor(SCREEN_HEIGHT / (CELL_SIZE + CELL_GUTTER));

const canvas = document.createElement('canvas');
canvas.width = colCount * CELL_SIZE + (colCount + 1) * CELL_GUTTER;
canvas.height = rowCount * CELL_SIZE + (rowCount + 1) * CELL_GUTTER;

document.body.appendChild(canvas);

const colors = ['#3E3E3E', '#FF2222', '#22FF22', '#FFFF22'];

// each cell holds an object containing: current color, target color, transition from back to front (0-1)
const grid = new Array(colCount * rowCount).fill(0).map(() => ({
  frontColor: 0,
  backColor: 0,
  transition: 1,
}));

/** @type {Widget[]} */
const widgets = [];

/**
 * @param {Widget} widget
 */
export function addWidget(widget) {
  widgets.push(widget);
}

let lastTime = Date.now();

const TRANSITION_DURATION = 300;

function render() {
  const now = Date.now();
  const delta = now - lastTime;
  lastTime = now;

  // update widgets each frame
  for (let k = 0; k < widgets.length; k++) {
    widgets[k].update();
  }

  const ctx = /** @type {CanvasRenderingContext2D} */ canvas.getContext('2d');
  ctx.fillStyle = '#1f1f1f';
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  for (let i = 0; i < colCount; i++) {
    for (let j = 0; j < rowCount; j++) {
      const gridCell = grid[i + j * colCount];

      // use clear color by default
      let newColor = 0;
      for (let k = 0; k < widgets.length; k++) {
        newColor = widgets[k].render(i, j, newColor);
      }

      if (newColor !== gridCell.frontColor) {
        gridCell.backColor = gridCell.frontColor;
        gridCell.frontColor = newColor;
        gridCell.transition = 0;
      }

      if (gridCell.transition < 0.5) {
        ctx.fillStyle = colors[gridCell.backColor];
      } else {
        ctx.fillStyle = colors[gridCell.frontColor];
      }
      const width = Math.abs(gridCell.transition * 2 - 1) * CELL_SIZE;
      const shift = (CELL_SIZE - width) / 2;

      const x = i * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER;
      const y = j * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER;
      const r = 4;
      ctx.beginPath();
      ctx.moveTo(x + shift + r, y);
      ctx.arcTo(x + shift + width, y, x + width + shift, y + CELL_SIZE, r);
      ctx.arcTo(x + shift + width, y + CELL_SIZE, x + shift, y + CELL_SIZE, r);
      ctx.arcTo(x + shift, y + CELL_SIZE, x + shift, y, r);
      ctx.arcTo(x + shift, y, x + shift + width, y, r);
      ctx.closePath();
      ctx.fill();

      gridCell.transition = Math.min(
        1,
        gridCell.transition + delta / TRANSITION_DURATION
      );
      // if (gridCell.transition === 1) {
      //   gridCell.backColor = gridCell.frontColor;
      // }
    }
  }

  requestAnimationFrame(render);
}

render();
