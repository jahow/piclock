const CELL_SIZE = 16;
const CELL_GUTTER = 4;

const SCREEN_WIDTH = 800;
const SCREEN_HEIGHT = 480;

const colCount = Math.floor(SCREEN_WIDTH / (CELL_SIZE + CELL_GUTTER));
const rowCount = Math.floor(SCREEN_HEIGHT / (CELL_SIZE + CELL_GUTTER));

const canvas = document.createElement('canvas');
canvas.width = colCount * CELL_SIZE + (colCount + 1) * CELL_GUTTER;
canvas.height = rowCount * CELL_SIZE + (rowCount + 1) * CELL_GUTTER;

document.body.appendChild(canvas);

const colors = ['#3E3E3E', '#FF2222', '#22FF22', '#FFFF22'];

// each cell holds an integer referencing the color
const grid = new Array(colCount * rowCount).fill(0);

/** @type {Widget[]} */
const widgets = [];

/**
 * @param {Widget} widget
 */
export function addWidget(widget) {
  widgets.push(widget);
}

function render() {
  // clear grid
  grid.fill(0);

  const ctx = /** @type {CanvasRenderingContext2D} */ canvas.getContext('2d');
  ctx.fillStyle = '#1f1f1f';
  ctx.fillRect(0, 0, canvas.width, canvas.height);

  for (let i = 0; i < colCount; i++) {
    for (let j = 0; j < rowCount; j++) {
      const gridIndex = i + j * colCount;

      for (let k = 0; k < widgets.length; k++) {
        grid[gridIndex] = widgets[k](i, j, grid[gridIndex]);
      }

      ctx.fillStyle = colors[grid[gridIndex]];
      const x = i * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER;
      const y = j * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER;
      const r = 4;
      ctx.beginPath();
      ctx.moveTo(x + r, y);
      ctx.arcTo(x + CELL_SIZE, y, x + CELL_SIZE, y + CELL_SIZE, r);
      ctx.arcTo(x + CELL_SIZE, y + CELL_SIZE, x, y + CELL_SIZE, r);
      ctx.arcTo(x, y + CELL_SIZE, x, y, r);
      ctx.arcTo(x, y, x + CELL_SIZE, y, r);
      ctx.closePath();
      ctx.fill();
    }
  }

  requestAnimationFrame(render);
}

render();
