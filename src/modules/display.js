const CELL_SIZE = 6;
const CELL_GUTTER = 4;

const SCREEN_WIDTH = 800;
const SCREEN_HEIGHT = 480;

const colCount = Math.floor(SCREEN_WIDTH / (CELL_SIZE + CELL_GUTTER));
const rowCount = Math.floor(SCREEN_HEIGHT / (CELL_SIZE + CELL_GUTTER));

const canvas = document.createElement('canvas');
canvas.width = colCount * CELL_SIZE + (colCount + 1) * CELL_GUTTER;
canvas.height = rowCount * CELL_SIZE + (rowCount + 1) * CELL_GUTTER;

document.body.appendChild(canvas);

const colors = ['#2c2c2c', '#FF2222', '#22FF22', '#FFFF22'];

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

  // update colors
  for (let i = 0; i < rowCount; i++) {
    for (let j = 0; j < colCount; j++) {
      const gridCell = grid[j + i * colCount];

      // use clear color by default
      let newColor = 0;
      for (let k = 0; k < widgets.length; k++) {
        newColor = widgets[k].render(j, i, newColor);
      }

      if (newColor !== gridCell.frontColor) {
        gridCell.backColor = gridCell.frontColor;
        gridCell.frontColor = newColor;
        gridCell.transition = 0;
      }

      // update transition value
      gridCell.transition = Math.min(
        1,
        gridCell.transition + delta / TRANSITION_DURATION
      );
    }
  }

  // draw grid
  for (let i = 0; i < rowCount; i++) {
    for (let j = 0; j < colCount; j++) {
      const gridCell = grid[j + i * colCount];

      ctx.strokeStyle = colors[gridCell.frontColor];
      ctx.lineWidth = gridCell.frontColor === 0 ? CELL_SIZE * 0.5 : CELL_SIZE;

      const x = j * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER;
      const y = i * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER + CELL_SIZE / 2;

      // check for similar neighboring cells
      let extraCells = 0;
      for (let k = j + 1; k < colCount; k++) {
        const nextGridCell = grid[k + i * colCount];
        if (nextGridCell.frontColor !== gridCell.frontColor) {
          break;
        }
        j++;
        extraCells++;
      }
      const width = CELL_SIZE + extraCells * (CELL_SIZE + CELL_GUTTER);

      ctx.beginPath();
      ctx.moveTo(x + 0.5, y);
      ctx.lineTo(x + width - 0.5, y);
      ctx.closePath();
      ctx.stroke();
    }
  }

  requestAnimationFrame(render);
}

render();
