import './modules/display';
import { addWidget } from './modules/display';
import { testWidget } from './modules/widgets/test';
import { clockWidget } from './modules/widgets/clock';
import { textWidget } from './modules/widgets/text';

addWidget(clockWidget(2, 38, 2));
addWidget(clockWidget(2, 44, 1));

addWidget(testWidget(10, 27, 8, 1));
addWidget(testWidget(18, 33, 4, 2));
addWidget(testWidget(26, 39, 6, 3));
addWidget(testWidget(32, 23, 13, 1));
addWidget(testWidget(52, 45, 20, 2));

addWidget(clockWidget(2, 2, 3));

addWidget(textWidget(2, 20, 'hello world!', 2));
addWidget(textWidget(2, 30, 'temp. good?', 1, 3));
