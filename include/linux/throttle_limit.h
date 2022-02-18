/*
 *  linux/include/linux/throttle_limit.h
 *
 */

#ifndef __THROTTLE_LIMIT_H__
#define __THROTTLE_LIMIT_H__

#ifdef CONFIG_ARM_EXYNOS_ACME
extern int get_gpu_throttle_limit(void);
#else
int get_gpu_throttle_limit(void)
{
	return 0;
}
#endif

#endif /* __THROTTLE_LIMIT_H__ */
