## CFAAction ##

[![Build Status](https://travis-ci.org/CodaFi/CFAAction.svg?branch=master)](https://travis-ci.org/CodaFi/CFAAction)

`CFAAction` is a wrapper around several common Core Animation animations that provides additional modularity and the ability to group and sequence actions.

## Getting Started
`CFAAction`'s should be treated like `SKAction`'s, which means they are only run when they are submitted to a variant of `-[CALayer runAction:]`.  

To run an action that moves a layer 10 pixels to the right in 1 second, for example, you can do:

```Objective-C
CFAAction *moveAction = [CFAAction moveByX:10 y:0 duration:1];
[self.view.layer runAction:growAnimation];
```
Completion blocks can be used to sequence animations:

```Objective-C
CFAAction *rotateAction = [CFAAction rotateToAngle:M_PI duration:1];
CFAAction *growAnimation = [CFAAction resizeToHeight:400 duration:0.25];

[self.view.layer runAction:rotateAction completion:^{
	[self.view.layer runAction:growAnimation];
}];
```

But, so can `+[CFAAction sequence:]`:

```Objective-C
CFAAction *rotateAction = [CFAAction rotateToAngle:M_PI duration:1];
CFAAction *growAnimation = [CFAAction resizeToHeight:400 duration:0.25];

[self.view.layer runAction:[CFAAction sequence:@[ rotateAction, growAnimation ]];
```

To run actions concurrently, there's `+[CFAAction group:]`:

```Objective-C
CFAAction *rotateAction = [CFAAction rotateToAngle:M_PI duration:1];
CFAAction *scaleAnimation = [CFAAction scaleBy:-0.25 duration:0.25];
[self.view.layer runAction:[CFAAction group:@[ scaleAnimation, rotateAction ]]];
```

To perform a block or selector as an action, use `[CFAAnimation runBlock:]`, `[CFAAnimation runBlock:queue:]`, or `[CFAAnimation performSelector:onTarget:]`.  When used in a group with a wait action, these can act as extensions for the total duration of the grouping.  When used in a sequence, they can act as delays before or after the selector is performed for precision timing.

```Objective-C
[self.planeLayer runAction:[CFAAction sequence:@[ bankAndRollAction, [CFAAction repeatAction:fireAction count:6] ]] completion:^{
		[self.enemy runAction:[CFAAction sequence:@[ dieAction, [CFAAction performSelector:@selector(die:) onTarget:self.enemy], [CFAAction waitForDuration:0.5] ]]];
}];
```
## License ##
`CFAAction` is licensed under the [MIT](http://opensource.org/licenses/MIT) license. See [LICENSE.md](LICENSE.md).

## Contact ##
Follow me on Twitter [@CodaFi_](https://twitter.com/CodaFi_), or visit [my website](http://λπω.com/).