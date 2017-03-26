#ifndef LLIST_H_
#define LLIST_H_

#include <stdint.h>

typedef char val_t[16];

/**
 * @struct node list.h "list.h"
 * @brief The basic element of the linked list
 */
typedef struct node {
    val_t data; /**< Data of the node */
    struct node *next;  /**< Pointer to the next node */
} node_t;

/**
 * @struct llist list.h "list.h"
 * @brief Store the information of the linked list.
 */
typedef struct {
    node_t *head;   /**< The head of the linked list */
    uint32_t size;  /**< The size of the linked list */
} llist_t;

llist_t *list_new();
int list_add(llist_t * const the_list, const val_t val);
void list_print(const llist_t * const the_list,  const char *filename);
node_t *list_get(llist_t * const the_list, const uint32_t index);
void list_free_nodes(llist_t *the_list);

#endif
