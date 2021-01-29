import './modules/display';
import { addWidget } from './modules/display';
import { testWidget } from './modules/widgets/test';
import { clockWidget } from './modules/widgets/clock';
import { textWidget } from './modules/widgets/text';
import { graphWidget } from './modules/widgets/graph';

addWidget(clockWidget(7, 2, 1));

// addWidget(testWidget(52, 45, 20, 2));

addWidget(textWidget(11, 19, 'lun. 04-02', 3));

// phase A: temp graph
addWidget(graphWidget(2, 23, 26, 37, 2, 3));
addWidget(textWidget(26, 26, 't°', 3));
addWidget(textWidget(26, 33, '18.2', 2));

addWidget(textWidget(50, 26, 'co2', 3));
addWidget(textWidget(45, 33, '2420', 2));

// phase b: weather forecast
// addWidget(textWidget(5, 26, 'o', 2));
// addWidget(textWidget(2, 33, '32', 2));
// addWidget(textWidget(18, 26, 'o', 2));
// addWidget(textWidget(15, 33, '32', 2));
// addWidget(textWidget(31, 26, 'o', 2));
// addWidget(textWidget(28, 33, '32', 2));
// addWidget(textWidget(44, 26, 'o', 2));
// addWidget(textWidget(41, 33, '32', 2));
// addWidget(textWidget(57, 26, 'o', 2));
// addWidget(textWidget(54, 33, '32', 2));
